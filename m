Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673828;
	b=FCgd325kFtxBVYXL//7Lz9X3rOvbEuVZ2UBZpsPOeSMjJSoJMqyGxqet9fUxsgPkNgxL
	 o6rQmQqbv3ubEzcAIPuxMlS/onNbho75bPsVGoQ/rX2c3uX5VzB04k4YIvKL0XLL78P71
	 7j57P3yWklGCZGLhumu8lHW60NYi8qQzIu5eCV/tCwA8gVuxRyKVk0Kdv4GhEWy2AAjjn
	 lDcd23ri/Bqr87eraJ1b3dyARseS0dHWTxLrvF/0kJiUfNBswVqKyVdl7LqtqMV5xhMUv
	 84Z+CpZCADLaK+kaYjLl+XUvd4qFLLN/MvPEy/A2iS4Aajb52R0xO2gJgt8B2nXlA/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673828;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xxxC/VqgSWcDOzXmk3VeIAFPBUB3paVgHQXE2J/B61Y=;
	b=LSH7irsmcuSHU8aZ2F81t55HoEyhGLaVzi+ZUdgfW3rgnNXhrU0u3f2bEE/eKgNLStTs
	 nb7DrtUX+0WFSzMO2tHkZHjgZZJ6vyOWEaIcDdQb2CeObTezhJcokz7ZbibK0K/i95W7h
	 t6tQGQhDbuPo63vpwRmxaRlhrtwT/G9wsH7uIkbnVIJdK9c/h9e5EB8nDrPV4lAY9QPu6
	 zCQoki2yqQHxZp65TQplQSr6HGjV0Ixk+C5h33rpTHFv0dxaKWeVhhUb3JnMB3DSIGUVt
	 MLa7q6XajSqTjLUrO4j10+c1PAKPIvwBRQV895h6pWRPR5ZXOgzc9oPzntI3E10ZgUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CtqWPRQ2;
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF98606A319;
	Thu, 22 Oct 2026 12:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CF98606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CtqWPRQ2
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792673820; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xxxC/VqgSWcDOzXmk3VeIAFPBUB3paVgHQXE2J/B61Y=;
	b=CtqWPRQ2XTDN6QQPmog3TZfHvM/temVlW17KLnwFpuaBE4khPBIQ1lSnnrMT/WjsLRZklO4qpGv8Fj/pnn/eLFpy4XOEEtkFoxSCVKiJ6urKI2aPPmi2KOkUNvrTgP5uE/kDdrfdUqrXkIsjtRmovXJPhuH6ZgvXYTO7K7s9SA0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDJJa91_1792673819;
Received: from 30.221.132.50(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0XDJJa91_1792673819 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Oct 2026 20:56:59 +0800
Message-ID: <d6e99a74-3b39-4797-a358-2e61156166a3@linux.alibaba.com>
Date: Thu, 22 Oct 2026 20:56:59 +0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/truncate: fix the zeroing end of
 pagecache_isize_extended()
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Brian Foster <bfoster@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20261016222721.791785-1-nickolai@csail.mit.edu>
Content-Language: en-US
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20261016222721.791785-1-nickolai@csail.mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/17 06:27, Nickolai Zeldovich wrote:
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
>
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

Looks good to me.

Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>

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


