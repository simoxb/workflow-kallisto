process cufflinks{
	
	label 'cufflinks'
	
	input:
	path(bam)
	path(gtf)
	
	output:
	
	
	script:
	"""
	cufflinks -g ${gtf} --library-type fr-unstranded --num-threads ${params.threads} ${bam}
	"""
}
