nextflow.enable.dsl=2

Channel.fromFilePairs(params.reads)
		.set{raw_input_ch}
		
include {fastp} from "./modules/fastp"
include {kallisto_index; kallisto_map} from "./modules/kallisto"
include {cufflinks} from "./modules/cufflinks"


workflow rnaseq{
	take: 
		fastq_input
			
	main:
		fastp(fastq_input)
		trimmed_input = fastp.out.trimmed	
		kallisto_index(params.transcriptome)
		index = kallisto_index.out.index
		kallisto_map(trimmed_input, index, params.gtf)
		bam_files = kallisto_map.out.bam
		cufflinks(bam_files, params.gtf)
}

workflow{
	rnaseq(raw_input_ch)	
}

