process kallisto_index{

	label 'kallisto'
	
	input: 
	path(fasta_input)
	
	output:
	path("${fasta_input.baseName}.index"), emit: index
	
	script:
	"""
	kallisto index -i ${fasta_input.baseName}.index ${fasta_input}
	"""
}

process kallisto_map{

	label 'kallisto'
	
	input:
	tuple val(pair_id), path(reads)
	path(index)
	path(gtf)
	
	output:
	
	script:
	"""
	kallisto quant -i ${index} -o ./ --gtf ${gtf} --genomebam ${reads[0]} ${reads[1]}
 	"""

}
