nextflow.enable.dsl=2



Channel.fromFilePairs(params.reads)
	.set{raw_input_ch}


include {fastp} from "./modules/fastp"
include {kallisto_index; kallisto_map} from "./modules/kallisto"
include {check_strandedness} from "./modules/check_strandedness"


workflow rnaseq{
	take: 
		fastq_input
			
	main:
		fastp(fastq_input)
		kallisto_index(params.transcriptome)
		check_strandedness(fastq_input, params.gtf, kallisto_index.out.index)
		kallisto_map(check_strandedness.out, fastp.out.trimmed, kallisto_index.out.index, params.gtf)
}

workflow{
	rnaseq(raw_input_ch)	
}

