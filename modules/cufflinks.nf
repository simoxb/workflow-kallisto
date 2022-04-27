process cufflinks{
	
	label 'cufflinks'
	
	input:
	path(bam)
	path(gtf)
	
	output:
	
	
	script:
	"""
	cufflinks -g ${gtf} ${bam}
	"""
}
