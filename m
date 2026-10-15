Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922F42E7366;
	Thu, 15 Oct 2026 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792039700; cv=none; b=sKJPocf7PB1zi3gaNJ7j8c5WpCcjtV76JNxZMWULWq60eJFKChRVmwp5tJvZd7Lvq+qdofoF9WfZHMqH5TtkWk1p3KNBfhSv//4YRGleaktQyQfRn/HrvNMEhHhvDChR/FJ6OAlEqbXyxC1BaSZ0+mwx+2ht0IqS8dJYIT4ZFCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792039700; c=relaxed/simple;
	bh=BL4VcGoROA7PDnT3vZ6aEr0VhdZPR/ihxMmEQPDm70M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gjj+UR9tu446uMpSmo54U/qXTX+7s1g0izU219dhYeiPff5iW8v88IsoFZV8LGFKyRowTfLbGbNdyiHuGV1Cuuc7SMjvo3raoflnJ+HW0l2omCMFyd6KA6OVKYYiRM2llE92uJwRxF66AAn+GF/jjytnVsrWc6+qIIkUNhESaYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGDqoKhF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGDqoKhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245AA1F000C5;
	Thu, 15 Oct 2026 04:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792039698;
	bh=6HMD5RchpGYsY0pRtaAyq/WdqXxarGhJNj4S4UKCbr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UGDqoKhFmdLWTU9OhCOSgo50nsXn0YVZhp/FbpZFeGwBctn7pug8HGkZTqeWCHxKm
	 xa1D3TEmpneVhIx2+Tero6MKORL1GupO/dubvGXy1VoKjMwzvK2MvSD2b2QdTPCoJo
	 HMlkkrZpOYmWT7HaUxU40aj2i2v5oNxrJMIoLOIBX1nEryVdK6Prp0OqWTT8+zstpv
	 Oy5z+HqMzwBby7BZ/BQAKoG5/ufi3sd0q2ELjLDilfW/yu7twZrn0CojcTU+1260Yw
	 SukxQDVaUQbjhVWRDBClFV/eYpYEJoP9aBsyZEIVVDVbENaEcTvTp0yiJRGwsy0/pi
	 +DECelzbkKd4A==
Date: Wed, 14 Oct 2026 21:48:17 -0700
From: Kees Cook <kees@kernel.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paul Burton <paulburton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: return the real error when program headers
 cannot be loaded
Message-ID: <202610142140.D483AE26DF@keescook>
References: <20261014-b4-prep-vstor-149847-binfmt_elf-enomem-load-elf-phdrs-v1-1-f39c74d55e42@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-b4-prep-vstor-149847-binfmt_elf-enomem-load-elf-phdrs-v1-1-f39c74d55e42@virtuozzo.com>

On Wed, Oct 14, 2026 at 02:30:33PM +0200, Konstantin Khorenko wrote:
> Problem
> =======
> 
> load_elf_phdrs() returns NULL on any failure, and load_elf_binary()
> turns that into a fixed error: -ENOEXEC for the executable, -ELIBBAD
> for its interpreter. The real cause is lost:
> 
>   cause                                  really      execve() returns
>   -------------------------------------  ----------  ----------------
>   bad e_phentsize, e_phnum 0 or too big  bad file    ENOEXEC (right)
>   file ends before the header table      bad file    ENOEXEC (right)
>   kmalloc() of the table fails           ENOMEM      ENOEXEC (wrong)
>   kernel_read() fails                    EIO/ENOMEM  ENOEXEC (wrong)
> 
> For the interpreter every row gives ELIBBAD.
> 
> Consequences
> ============
> 
> ENOEXEC says the file is not an executable, which is a property of the
> file, not a transient failure:
> 
> - glibc's execvp() and execlp() take ENOEXEC as "not a binary" and run
>   the ELF file with /bin/sh, which reports a binary it cannot execute
>   instead of the ENOMEM or EIO.
> - search_binary_handler() tries the next binary format instead of
>   returning the error.

Isn't that what we want? If one handler can't load it, move on to find
one that does.

> - For the interpreter the caller gets ELIBBAD, "Accessing a corrupted
>   shared library", about an ld.so that is fine.
> - A caller that would retry on ENOMEM or report EIO gives up on the
>   file instead.
> 
> When it happens
> ===============
> 
> - The allocation fails under fault injection. Since commit
>   8030790477e8 ("binfmt_elf: remove the 4k limitation of program header
>   size") the table may be up to 64K; above 32K that is an order-4
>   allocation on 4K-page kernels, which can fail on a fragmented system.

I would not want to risk changing established userspace error message
interactions to make fault injection happy.

> - The read fails with an I/O error, or with -ENOMEM when the page cache
>   cannot take the pages.

This is kind of a bad failure case -- I don't think the "right" error
code is going to help much there. ;)

> 
> Where it came from
> ==================
> 
> - Until commit 6a8d38945cf4 ("binfmt_elf: Hoist ELF program header
>   loading to a function") load_elf_binary() returned -ENOMEM and the
>   read error. That commit documented an ERR_PTR return but returned
>   NULL; commit cfc46ca4fdca later fixed the comment, not the code.
> - Commit a9d9ef133f44 ("binfmt_elf: load interpreter program headers
>   earlier") gave the interpreter's headers the same NULL check, and with
>   it -ELIBBAD.

So it's been like this for 12 years? :)

> [...]
>   kernel                errors returned by execve()
>   7.3-rc7               ENOMEM 17, ENOEXEC 1, ELIBBAD 1, E2BIG 2
>   7.3-rc7 + this patch  ENOMEM 19, E2BIG 2

... so there are _fewer_ distinct failure codes with the patch?

> +	/*
> +	 * Read in the program headers. A read that fails part way returns
> +	 * what it got, so read on to see the error or the end of the file.
> +	 */
> +	pos = elf_ex->e_phoff;
> +	for (done = 0; done < size; done += rv) {
> +		rv = kernel_read(elf_file, (char *)elf_phdata + done,
> +				 size - done, &pos);
> +		if (rv <= 0) {
> +			kfree(elf_phdata);
> +			return ERR_PTR(rv ? rv : -ENOEXEC);
> +		}
>  	}

This is a behavioral change mixed into the errno handling change to
support partial reads??

I could be convinced that errnos need to be fixed, but the rationale
here doesn't really make me think it's worth potential disruption to
userspace. I'd need a pretty comprehensive survey of what would change
there and then a clean patch that made zero other behavior changes...

-Kees

-- 
Kees Cook
