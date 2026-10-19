Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2A3DC4C8;
	Mon, 19 Oct 2026 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409448; cv=none; b=s09fwliMmaXz4VpImNieCKHRT399mE37dQ9HOMwJZvJ23So8OPY2WWsI11y096Pk8xlfpsUH5Bch9wiR3WMCKmv/XhAgOa9JNPj1U765RERAjnKizp0v5WjDHUD3XqTWtlCHU7tQW2o1g8Fs/2o2zBKsXgGp+LWM+CcjFX37Hg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409448; c=relaxed/simple;
	bh=HslpktidHJ8ffLNJ3jl2Oo/mPmgry/UzkboytPQDsD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKWPdlLR4otSn+rneQZ1kP3Aw7+utMCQ3jZJ3gORRvRP/5lzHZHIeXfpSXJIbc3J2AIiRXt1sdbNNsEPOJbkXYTExQuS1vNaf2Uzi9NPYIzeRKf9rloYOm/9dNHQa40Y7BtKgqrnRACbKutn8wJucK++2+VVNOyimBcaebKyvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L6O2T2x9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H3OGq6vW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L6O2T2x9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H3OGq6vW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L6O2T2x9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H3OGq6vW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L6O2T2x9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H3OGq6vW"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73CAB21C5D;
	Mon, 19 Oct 2026 11:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792409444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gWeSLpyc5O1IcgR6SkOdVi69vnfzBIqmPx/MkGbdVCU=;
	b=L6O2T2x9pSLXoAEQlsmjHrrlsPwnlVdfuIgN0qbTfEVWTSnrY/yP3H1h67Rrav/3ml7vgr
	sYMquu3X0n2E0sMKEUYRRxoLXN/Fe+iFiwhrNTtrijGZZgPKPhw2o6UQ1Iocq+dLrXcQCE
	rsRI1icyDY9oGLpqyZw2dBBw6l+GJcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792409444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gWeSLpyc5O1IcgR6SkOdVi69vnfzBIqmPx/MkGbdVCU=;
	b=H3OGq6vW1LSBbUwIQtir4GTqkGn4jFhwdkH2E4CLsHm/tdwz/hhMmQ+qR4wSWu0bBXSuWt
	Gtx1HIIQndRXOtAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792409444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gWeSLpyc5O1IcgR6SkOdVi69vnfzBIqmPx/MkGbdVCU=;
	b=L6O2T2x9pSLXoAEQlsmjHrrlsPwnlVdfuIgN0qbTfEVWTSnrY/yP3H1h67Rrav/3ml7vgr
	sYMquu3X0n2E0sMKEUYRRxoLXN/Fe+iFiwhrNTtrijGZZgPKPhw2o6UQ1Iocq+dLrXcQCE
	rsRI1icyDY9oGLpqyZw2dBBw6l+GJcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792409444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gWeSLpyc5O1IcgR6SkOdVi69vnfzBIqmPx/MkGbdVCU=;
	b=H3OGq6vW1LSBbUwIQtir4GTqkGn4jFhwdkH2E4CLsHm/tdwz/hhMmQ+qR4wSWu0bBXSuWt
	Gtx1HIIQndRXOtAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A9A7134B3;
	Mon, 19 Oct 2026 11:30:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4JMqCmT/1WooLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Oct 2026 11:30:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE575A1413; Mon, 19 Oct 2026 13:30:39 +0200 (CEST)
Date: Mon, 19 Oct 2026 13:30:39 +0200
From: Jan Kara <jack@suse.cz>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Brian Foster <bfoster@redhat.com>, Theodore Ts'o <tytso@mit.edu>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/truncate: fix the zeroing end of
 pagecache_isize_extended()
Message-ID: <uolyy5wn2oc7iiu3e3vlsp5m6yjlsakwcjtsuzklbe3mk72ruu@qlrdp3q35igz>
References: <20261016222721.791785-1-nickolai@csail.mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016222721.791785-1-nickolai@csail.mit.edu>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]

On Fri 16-10-26 18:27:21, Nickolai Zeldovich wrote:
> A process that extends a file by 4 GiB or more past a dirty folio, on a
> file system whose block size is smaller than the page size (ext4 with 1k
> blocks), reads back the bytes it wrote through a shared mapping beyond
> the old end of file instead of zeroes, and a later write into that block
> carries them to the disk. With the example of commit 52aecaee1c26 ("mm:
> zero range of eof folio exposed by inode size extension") and the
> truncate taken 4 GiB further (pwrite 2k at 0, mmap the first page and
> write 'X' over [2k, 4k), truncate(2) to 4 GiB + 2k), the read of
> [2k, 4k) returns the 2048 'X' bytes, and a pwrite of 16 bytes at 3k
> followed by fsync() and a remount leaves 1008 'X' bytes on the disk in
> [3k+16, 4k). No privilege is needed, and every size extension of 4 GiB
> or more reaches it: truncate(2)/ftruncate(2) through truncate_setsize(),
> writes beyond the end of file through generic_write_end(), ext4, iomap,
> btrfs, exfat, ntfs, afs and orangefs. Affected since v6.13.

Frankly, I find this paragraph useless. Everything is said below in a more
understandable way. I'd just drop it.

> pagecache_isize_extended() zeroes the part of the dirty folio straddling
> the old end of file that the size extension exposes, from the old size
> to the new size or the end of the folio, whichever comes first:
> 
> 	end = min_t(unsigned int, to - folio_pos(folio), folio_size(folio));
> 
> min_t() converts both operands to unsigned int before comparing, so the
> loff_t difference to - folio_pos(folio) is reduced modulo 2^32 first.
> When the file grows by 4 GiB or more past the folio, end is that residue
> instead of folio_size(folio): below offset nothing is zeroed, above it
> only [offset, end) is. The bytes beyond the old end of file stay in the
> dirty folio and, now inside i_size, are file data.
> 
> Compare in loff_t; the result is at most folio_size(folio) and fits end.
> 
> Found while formally verifying pagecache_isize_extended() against the
> kernel binary.
> 
> Fixes: 52aecaee1c26 ("mm: zero range of eof folio exposed by inode size extension")
> Assisted-by: LLM
> Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>

The fix looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Notes:
>     Tested on a 64 MiB ext4 image made with mkfs.ext4 -b 1024 and mounted in
>     a QEMU guest, with the program below followed by umount, mount and a
>     read of [3k+16, 4k). Unpatched 70dd4ee72eb2 (x86_64 and riscv64
>     defconfig): 2048 of 2048 bytes non-zero ('X') after the truncate and
>     1008 of 1008 'X' bytes on the disk after the remount. Patched: 0 and 0.
>     The same sequence with a truncate to 8k reads zeroes on both kernels,
>     which is the case commit 52aecaee1c26 fixed.
>     
>     The 32-bit conversion is visible in the riscv64 binary as a subw on the
>     loff_t difference before the compare; with the patch it is a sub.
>     
>     Reproducer (ext4 with 1k blocks, mkfs.ext4 -b 1024):
>     
>     truncate -s 64M img && mkfs.ext4 -q -F -b 1024 img && mount -o loop img /mnt
>     gcc -O2 -o isize_extended isize_extended.c
>     ./isize_extended /mnt/f    # exit 1 and a non-zero count on an unpatched kernel
>     
>     /*
>      * Stale post-EOF data after a size extension of 4 GiB or more on a file
>      * system with a block size below the page size (ext4 -b 1024): [2k, 4k)
>      * must read as zeroes after the truncate.  Exit status 1 when it does not.
>      */
>     #include <fcntl.h>
>     #include <stdio.h>
>     #include <string.h>
>     #include <sys/mman.h>
>     #include <unistd.h>
>     
>     int main(int argc, char **argv)
>     {
>     	const char *path = argc > 1 ? argv[1] : "/mnt/f";
>     	unsigned char buf[4096];
>     	unsigned int i, nz = 0;
>     	char *map;
>     	int fd;
>     
>     	fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0644);
>     	memset(buf, 'A', 2048);
>     	if (fd < 0 || pwrite(fd, buf, 2048, 0) != 2048) {
>     		perror("open/pwrite");
>     		return 2;
>     	}
>     	/* 'X' beyond EOF, inside the first page; the folio stays dirty */
>     	map = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>     	if (map == MAP_FAILED) {
>     		perror("mmap");
>     		return 2;
>     	}
>     	memset(map + 2048, 'X', 2048);
>     	munmap(map, 4096);
>     	/* 4 GiB or more past the folio: to - folio_pos(folio) >= 2^32 */
>     	if (ftruncate(fd, 4294967296LL + 2048)) {
>     		perror("ftruncate");
>     		return 2;
>     	}
>     	if (pread(fd, buf, 2048, 2048) != 2048) {
>     		perror("pread");
>     		return 2;
>     	}
>     	for (i = 0; i < 2048; i++)
>     		nz += buf[i] != 0;
>     	printf("[2k,4k) after truncate to 4 GiB + 2k: %u non-zero bytes of 2048\n", nz);
>     	/* allocate block [3k, 4k): [3k+16, 4k) shows what reaches the disk */
>     	memset(buf, 'B', 16);
>     	if (pwrite(fd, buf, 16, 3072) != 16 || fsync(fd)) {
>     		perror("pwrite/fsync");
>     		return 2;
>     	}
>     	return nz ? 1 : 0;
>     }
> 
>  mm/truncate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index b58ba940be47..5c444812f37a 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -878,8 +878,7 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
>  		unsigned int offset, end;
>  
>  		offset = from - folio_pos(folio);
> -		end = min_t(unsigned int, to - folio_pos(folio),
> -			    folio_size(folio));
> +		end = min_t(loff_t, to - folio_pos(folio), folio_size(folio));
>  		folio_zero_segment(folio, offset, end);
>  	}
>  
> 
> base-commit: 70dd4ee72eb2d5793c62e71c14e3aba78e5a4e56
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
