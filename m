Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397D28641F;
	Wed, 18 Mar 2026 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848090; cv=none; b=c/LL7NorbQGPITDkDCKfIduyW6HEdAQa1aY9Lqo80mNQcd0zWjnOPHivqVsjiZuOfIjJRN3BirP+R/qDCBlrd8wGyF3IaMW/xaZU8OffU6vvljydvczwMQwebJhpMeDnZxjW0vy3n5Am2hpJ83qzmHlGXSySEUkanNdz8ihqLHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848090; c=relaxed/simple;
	bh=I9m3m+lj3Kdo/1z7z8+rLswyz3vsro5sTPl1/DXLwf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QivYK/y3IOZSiSc3Oen0IllBiioFoivGGrbvo2XaYdADpkbsY6yjaMVzUD2wU5NFNmJ5vEk5WktI69QJ3rum1yN6eAG+9mnmRP8kRydOIKwALbCyl4kvnkIYMLMkjJw8NZIr5t5pHwY/7aebz465I1x9bBnR9HK3YkrzIDRz0wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKN6/vFy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKN6/vFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCD1C19421;
	Wed, 18 Mar 2026 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773848090;
	bh=I9m3m+lj3Kdo/1z7z8+rLswyz3vsro5sTPl1/DXLwf8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WKN6/vFyDilBssNT5JgFqRVCYXFtzNmnkxFd3Ew8eVUrvJ69QIrFfz3FMX1267xSv
	 6pmmCihbsW0rXoAR9zl4gfXsikZa5aB6arf8364Aa5oDxc5o0dh2rOy91XeL+2gduO
	 FD6WiiRiPklZd7IGwossWcTdOOh6vGUcYF/B44jpsZCVr0B8pbERdBSeRnRZXS9VGM
	 8gVXCoP0amimcOBuVQKI0Q+3dcCDIZIJ1TQeczaeWUKTJhy7/szPMEJ8e9sonwUk7V
	 /XI9Hx+9pdR6oxwEd1EDXLopDjC2ZKkHpxDygx/S669BmGHdoifA64cgye8wF/vBuo
	 t6Ea1cueIEBkA==
Message-ID: <882b0de0-2bfc-460b-8ef8-e4a2583f6c74@kernel.org>
Date: Wed, 18 Mar 2026 16:34:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fs: Replace user_access_{begin/end} by scoped user
 access
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <f46941437f681cc72fc5a84fa768f65b952f43c6.1773830446.git.chleroy@kernel.org>
 <20260318142140.3f94510c@pumpkin>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260318142140.3f94510c@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/03/2026 à 15:21, David Laight a écrit :
> On Wed, 18 Mar 2026 13:22:43 +0100
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> 
>> Scoped user access reduces code complexity and seamlessly bring
>> masked user access on architectures that support it.
>>
>> Replace user_access_begin/user_access_end blocks by
>> scoped user access.
>>
>> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> ---
>> v2:
>> - Fix build failure with CONFIG_COMPAT
>> - Handled checkpatch.pl output
>>
>> v3:
>> - Fix again build failure with CONFIG_COMPAT. I was obviously too tired when I sent out v2.
>>
>> v4:
>> - Introduced local size var based on Linus comment on readability. Not a dirent_size() helper as suggested as both sites are different.
>> ---
>>   fs/readdir.c | 94 +++++++++++++++++++++-------------------------------
>>   fs/select.c  | 35 ++++++++-----------
>>   2 files changed, 51 insertions(+), 78 deletions(-)
>>
>> diff --git a/fs/readdir.c b/fs/readdir.c
>> index 73707b6816e9..8fa615b7e950 100644
>> --- a/fs/readdir.c
>> +++ b/fs/readdir.c
>> @@ -184,6 +184,7 @@ static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
>>   	struct readdir_callback *buf =
>>   		container_of(ctx, struct readdir_callback, ctx);
>>   	struct old_linux_dirent __user * dirent;
>> +	size_t size = offsetof(struct old_linux_dirent, d_name) + namlen + 1;
>>   	unsigned long d_ino;
>>   
>>   	if (buf->result)
>> @@ -198,18 +199,13 @@ static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
>>   	}
>>   	buf->result++;
>>   	dirent = buf->dirent;
>> -	if (!user_write_access_begin(dirent,
>> -			(unsigned long)(dirent->d_name + namlen + 1) -
>> -				(unsigned long)dirent))
>> -		goto efault;
>> -	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
>> -	unsafe_put_user(offset, &dirent->d_offset, efault_end);
>> -	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
>> -	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
>> -	user_write_access_end();
>> +	scoped_user_write_access_size(dirent, size, efault) {
> 
> The problem now is that it isn't obviously clear that 'size' is correct.
> If nothing else its definition is quite a way up from the use.

The definition and use are 15 lines apart, you can see both on the 
screen at the same time. Is it really too many lines ?

I choosed to put it close to the declaration of dirent to make sure the 
type is the right one.

> Perhaps putting:
> 	size = offsetof(typeof(*dirent), d_name) + namelen + 1;
> immediately before the scoped_user_write_access_size() would be better.

Ok yes, using typeof(*dirent) we can move it closer to 
scoped_user_write_access_size()

> Perhaps even renaming it dirent_len.

Yes why not.

Will wait a few days and send a v5.

Christophe

> 
> 	David
> 
>> +		unsafe_put_user(d_ino, &dirent->d_ino, efault);
>> +		unsafe_put_user(offset, &dirent->d_offset, efault);
>> +		unsafe_put_user(namlen, &dirent->d_namlen, efault);
>> +		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
>> +	}
>>   	return true;
>> -efault_end:
>> -	user_write_access_end();
>>   efault:
>>   	buf->result = -EFAULT;
>>   	return false;
>> @@ -287,23 +283,19 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
>>   		return false;
>>   	dirent = buf->current_dir;
>>   	prev = (void __user *) dirent - prev_reclen;
>> -	if (!user_write_access_begin(prev, reclen + prev_reclen))
>> -		goto efault;
>> -
>> -	/* This might be 'dirent->d_off', but if so it will get overwritten */
>> -	unsafe_put_user(offset, &prev->d_off, efault_end);
>> -	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
>> -	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
>> -	unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault_end);
>> -	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
>> -	user_write_access_end();
>> +	scoped_user_write_access_size(prev, reclen + prev_reclen, efault) {
>> +		/* This might be 'dirent->d_off', but if so it will get overwritten */
>> +		unsafe_put_user(offset, &prev->d_off, efault);
>> +		unsafe_put_user(d_ino, &dirent->d_ino, efault);
>> +		unsafe_put_user(reclen, &dirent->d_reclen, efault);
>> +		unsafe_put_user(d_type, (char __user *)dirent + reclen - 1, efault);
>> +		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
>> +	}
>>   
>>   	buf->current_dir = (void __user *)dirent + reclen;
>>   	buf->prev_reclen = reclen;
>>   	ctx->count -= reclen;
>>   	return true;
>> -efault_end:
>> -	user_write_access_end();
>>   efault:
>>   	buf->error = -EFAULT;
>>   	return false;
>> @@ -371,24 +363,20 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
>>   		return false;
>>   	dirent = buf->current_dir;
>>   	prev = (void __user *)dirent - prev_reclen;
>> -	if (!user_write_access_begin(prev, reclen + prev_reclen))
>> -		goto efault;
>> -
>> -	/* This might be 'dirent->d_off', but if so it will get overwritten */
>> -	unsafe_put_user(offset, &prev->d_off, efault_end);
>> -	unsafe_put_user(ino, &dirent->d_ino, efault_end);
>> -	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
>> -	unsafe_put_user(d_type, &dirent->d_type, efault_end);
>> -	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
>> -	user_write_access_end();
>> +	scoped_user_write_access_size(prev, reclen + prev_reclen, efault) {
>> +		/* This might be 'dirent->d_off', but if so it will get overwritten */
>> +		unsafe_put_user(offset, &prev->d_off, efault);
>> +		unsafe_put_user(ino, &dirent->d_ino, efault);
>> +		unsafe_put_user(reclen, &dirent->d_reclen, efault);
>> +		unsafe_put_user(d_type, &dirent->d_type, efault);
>> +		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
>> +	}
>>   
>>   	buf->prev_reclen = reclen;
>>   	buf->current_dir = (void __user *)dirent + reclen;
>>   	ctx->count -= reclen;
>>   	return true;
>>   
>> -efault_end:
>> -	user_write_access_end();
>>   efault:
>>   	buf->error = -EFAULT;
>>   	return false;
>> @@ -446,6 +434,7 @@ static bool compat_fillonedir(struct dir_context *ctx, const char *name,
>>   	struct compat_readdir_callback *buf =
>>   		container_of(ctx, struct compat_readdir_callback, ctx);
>>   	struct compat_old_linux_dirent __user *dirent;
>> +	size_t size = offsetof(struct compat_old_linux_dirent, d_name) + namlen + 1;
>>   	compat_ulong_t d_ino;
>>   
>>   	if (buf->result)
>> @@ -460,18 +449,13 @@ static bool compat_fillonedir(struct dir_context *ctx, const char *name,
>>   	}
>>   	buf->result++;
>>   	dirent = buf->dirent;
>> -	if (!user_write_access_begin(dirent,
>> -			(unsigned long)(dirent->d_name + namlen + 1) -
>> -				(unsigned long)dirent))
>> -		goto efault;
>> -	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
>> -	unsafe_put_user(offset, &dirent->d_offset, efault_end);
>> -	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
>> -	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
>> -	user_write_access_end();
>> +	scoped_user_write_access_size(dirent, size, efault) {
>> +		unsafe_put_user(d_ino, &dirent->d_ino, efault);
>> +		unsafe_put_user(offset, &dirent->d_offset, efault);
>> +		unsafe_put_user(namlen, &dirent->d_namlen, efault);
>> +		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
>> +	}
>>   	return true;
>> -efault_end:
>> -	user_write_access_end();
>>   efault:
>>   	buf->result = -EFAULT;
>>   	return false;
>> @@ -543,22 +527,18 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
>>   		return false;
>>   	dirent = buf->current_dir;
>>   	prev = (void __user *) dirent - prev_reclen;
>> -	if (!user_write_access_begin(prev, reclen + prev_reclen))
>> -		goto efault;
>> -
>> -	unsafe_put_user(offset, &prev->d_off, efault_end);
>> -	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
>> -	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
>> -	unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault_end);
>> -	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
>> -	user_write_access_end();
>> +	scoped_user_write_access_size(prev, reclen + prev_reclen, efault) {
>> +		unsafe_put_user(offset, &prev->d_off, efault);
>> +		unsafe_put_user(d_ino, &dirent->d_ino, efault);
>> +		unsafe_put_user(reclen, &dirent->d_reclen, efault);
>> +		unsafe_put_user(d_type, (char __user *)dirent + reclen - 1, efault);
>> +		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
>> +	}
>>   
>>   	buf->prev_reclen = reclen;
>>   	buf->current_dir = (void __user *)dirent + reclen;
>>   	ctx->count -= reclen;
>>   	return true;
>> -efault_end:
>> -	user_write_access_end();
>>   efault:
>>   	buf->error = -EFAULT;
>>   	return false;
>> diff --git a/fs/select.c b/fs/select.c
>> index e0244dbe4429..75978b18f48f 100644
>> --- a/fs/select.c
>> +++ b/fs/select.c
>> @@ -1004,17 +1004,17 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
>>   	fdcount = do_poll(head, &table, end_time);
>>   	poll_freewait(&table);
>>   
>> -	if (!user_write_access_begin(ufds, nfds * sizeof(*ufds)))
>> -		goto out_fds;
>> +	scoped_user_write_access_size(ufds, nfds * sizeof(*ufds), out_fds) {
>> +		struct pollfd __user *_ufds = ufds;
>>   
>> -	for (walk = head; walk; walk = walk->next) {
>> -		struct pollfd *fds = walk->entries;
>> -		unsigned int j;
>> +		for (walk = head; walk; walk = walk->next) {
>> +			struct pollfd *fds = walk->entries;
>> +			unsigned int j;
>>   
>> -		for (j = walk->len; j; fds++, ufds++, j--)
>> -			unsafe_put_user(fds->revents, &ufds->revents, Efault);
>> -  	}
>> -	user_write_access_end();
>> +			for (j = walk->len; j; fds++, _ufds++, j--)
>> +				unsafe_put_user(fds->revents, &_ufds->revents, out_fds);
>> +		}
>> +	}
>>   
>>   	err = fdcount;
>>   out_fds:
>> @@ -1026,11 +1026,6 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
>>   	}
>>   
>>   	return err;
>> -
>> -Efault:
>> -	user_write_access_end();
>> -	err = -EFAULT;
>> -	goto out_fds;
>>   }
>>   
>>   static long do_restart_poll(struct restart_block *restart_block)
>> @@ -1338,15 +1333,13 @@ static inline int get_compat_sigset_argpack(struct compat_sigset_argpack *to,
>>   					    struct compat_sigset_argpack __user *from)
>>   {
>>   	if (from) {
>> -		if (!user_read_access_begin(from, sizeof(*from)))
>> -			return -EFAULT;
>> -		unsafe_get_user(to->p, &from->p, Efault);
>> -		unsafe_get_user(to->size, &from->size, Efault);
>> -		user_read_access_end();
>> +		scoped_user_read_access(from, efault) {
>> +			unsafe_get_user(to->p, &from->p, efault);
>> +			unsafe_get_user(to->size, &from->size, efault);
>> +		}
>>   	}
>>   	return 0;
>> -Efault:
>> -	user_read_access_end();
>> +efault:
>>   	return -EFAULT;
>>   }
>>   
> 

