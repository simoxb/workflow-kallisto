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
		kallisto_index(params.transcriptome)
		kallisto_map(fastp.out.trimmed, kallisto_index.out.index, params.gtf)
		cufflinks(kallisto_map.out.bam, params.gtf)
}

workflow{
	rnaseq(raw_input_ch)	
}

