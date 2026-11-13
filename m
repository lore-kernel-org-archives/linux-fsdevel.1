Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563838;
	b=O2H02nG/X6vY6j3Wejd3c9hgQ2ICmFrefyL2UopO+Re4Uk4Z7nNaIeWVcvqiX1epnUtJ
	 su3SMv4OYMeQlNdMVsrfrRxIzBddkj6CEl9p5yUmsCRoWqrWRZwrnS+HlQMrIm6b1exon
	 Lv61g3yGKQqDxkKpRBUEczjWYl+Xv/gA0AwbnZB8ylajYX9oW8Q3LiU0xQBDryHkYHVM+
	 fy8U6qFecnO9XHZFUnDjoSjDxPAyCFcxqIMyvJywtaVBp2zIqMw4LFZ7zM+F6r1RffKe9
	 DOLf1dwRrwcCh+GveVR0plusX8IgT13chLM8MWxs65gc6+BMdw9coLMsgP6DpsU75eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563838;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=qevJKKt9AdENPu2sz0SerhnvIVfDVH7XwpJ2scdcBAA=;
	b=Yw1aTxTbPc1n2pNSDzeiyngC9Ju6aWAPMecah0zKPhh5oABrwQ7EpdyRJSKNC2PIODMg
	 /vnXn9ADT91zp9kuDkbBtP1a63B/XsqHYg0r8E78j1mJUyTtvnKiP4NkB7XtDzcphnd34
	 /j2wNWEgbhk3UwOtmTLMrYOMN5yj+UTMgbqU1D5HmkiuNS32sNVrLz5yKqdGFJs4f8Z8g
	 g0RPAa8QZass0QICIlxO+DT+GxQXA++fZ1QRgOhROKt6sVASl7X2OgMY9jYBVeMlA9pn/
	 51OxFop5zpu9W1j0Qnk+hjObxetl+B+P87EdV6Gke7Wbxpf5hm3VWbqwCoyS8273Pow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=khX0GR6E;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kR2FEpc1;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=s83j7XjY;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mKkZihpV;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F0606A327
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 09:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD7F0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=khX0GR6E;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kR2FEpc1;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=s83j7XjY;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mKkZihpV
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB8AC1F863;
	Fri, 13 Nov 2026 09:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794563835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qevJKKt9AdENPu2sz0SerhnvIVfDVH7XwpJ2scdcBAA=;
	b=khX0GR6E6FIZA53QjNbXduKxHV+kafIkyjv/Wfz2MLuFW+Fq+xoIwIuQP3iDzQbjQR8d2i
	7dAuyGHlTT8k6oWSSUvJejnvu8lMTnlaIB+c3C4RteEcQZ00931vCOhdTFZNglwhM1MiYT
	9LYQUvvoyYAdleXOb1GTOhct6HWVxh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794563835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qevJKKt9AdENPu2sz0SerhnvIVfDVH7XwpJ2scdcBAA=;
	b=kR2FEpc1pVlZv2UdkYBcJl6qyvYtWIcxN84+u6IoARccPHsBDs1eLZgnqHqvnExQUbdhLh
	ofGuG6L7jHWOSDCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794563834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qevJKKt9AdENPu2sz0SerhnvIVfDVH7XwpJ2scdcBAA=;
	b=s83j7XjYvZ4yqU7+dWSzfj/ElEcmuVMZMkYc+9X0BACDMcM5JHtJ9i1gbnd6krT/88hcIV
	B1YZlenZVhp+stNUD87RaWrMA18SIf3bdpY8x5J9umFpGkZ1r8+LR1Sm84WBNxvTR4JNC4
	uL52B0kqYO3Z3pt/LPdbIbXOnbXs7Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794563834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qevJKKt9AdENPu2sz0SerhnvIVfDVH7XwpJ2scdcBAA=;
	b=mKkZihpV+gEFWIt8Ewzrw54dmXpx72u62aZ3orDBke/ks+NDJp9cqfbWLiedalC6iMUV68
	nT8TaKgLoNJZwWDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7402F134F4;
	Fri, 13 Nov 2026 09:57:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ja2GFfre9moXXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 09:57:14 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 0AA1B22C6A; Fri, 13 Nov 2026 10:57:06 +0100 (CET)
Date: Fri, 13 Nov 2026 10:57:06 +0100
From: Jan Kara <jack@suse.cz>
To: Scott Carter <bscarter11@gmail.com>
Cc: jack@suse.com, linux-fsdevel@vger.kernel.org
Subject: Re: udf: readdir loops forever re-emitting the last entry when a
 directory's final FID straddles EOF
Message-ID: <viedwv4i5w2oxld2mjzxmqa6kwtutt6olhir6sc3756niya74z@tkvglz6rr7i7>
References: <CA+UmNqbcPPegp=x8rsV8t3mbOsseknKo54=fsru6gb3PQjg+Dw@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+UmNqbcPPegp=x8rsV8t3mbOsseknKo54=fsru6gb3PQjg+Dw@mail.gmail.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,repro.sh:url,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

Hi!

On Tue 27-10-26 19:32:18, Scott Carter wrote:
> When a UDF directory's information length leaves a tail shorter than
> sizeof(struct fileIdentDesc) after its last FID, readdir never
> terminates. Each getdents64() call returns the last entry again.
> 
> Seen on 7.2.11 (Fedora/Nobara 7.2.11-200.nobara.fc44.x86_64) with a
> pressed DVD-Video disc (UDF bridge), mounted read-only. "ls" on the
> root grew to 15 GB RSS in two minutes. A capped os.scandir() of the
> root returned the same name 491 times in 500 entries. The kernel log
> repeats:
> 
> UDF-fs: error (device sr0): udf_copy_fi: directory (ino 667) has
> entry straddling EOF

Thanks for report and the reproducer! I've just sent out a fix (similar to
your proposal) to avoid looping for such directories and I'll merge it
through my tree. I was considering gracefully handling such situation
without reporting corruption and it is easy enough for readdir but it would
complicate the code when adding new entries to the directory (when we treat
this as a corruption, attempt to add entry to such directory just fails) so
I'm inclined to keep reporting errors for such directories. If such
incorrect directories would be widespread, then I guess I could convince
myself to complicate the directory append code for it but for now I don't
think it's worth it.

								Honza

> 
> The code involved is unchanged in current mainline (line numbers
> below are from master as of 744e5400b36f):
> 
> 1. fs/udf/dir.c:89, udf_readdir() sets ctx->pos = (iter.pos >> 2) + 1
> for the current entry before dir_emit() at line 114.
> 
> 2. The loop's udf_fiiter_advance() (dir.c:79) moves iter->pos past the
> last FID (directory.c:298). udf_copy_fi() (directory.c:317) then
> fails at directory.c:79-84 with -EFSCORRUPTED, because fewer than
> 38 bytes remain.
> 
> 3. dir.c:118 updates ctx->pos only when ret == 0, so it still points
> at the entry that was just emitted. The error is returned at
> dir.c:129.
> 
> 4. fs/readdir.c:407-415: getdents64() has already filled entries, so
> it returns the byte count and drops the error.
> 
> 5. The next getdents64() resumes at the last emitted entry, emits it
> again and fails again, and so on.
> 
> Reproducer: repro.sh and repro.img.xz are attached (2552 bytes; it
> decompresses to a 2 MiB UDF 1.02 image with 2048-byte blocks). The
> image is mkudffs plus 60 empty files in the root. The root directory's
> informationLength and its last extent length were then grown by 4
> bytes, with the descriptor CRC and checksum fixed up, which leaves 4
> bytes after the last FID. "./repro.sh build" recreates the image. Do
> not list the image without a memory cap:
> 
> sudo mount -o loop,ro repro.img /mnt
> systemd-run --user --scope -p MemoryMax=256M -p MemorySwapMax=0 \
> timeout 10 ls -f /mnt 2>&1 | head -5000 | sort | uniq -c | \
> sort -rn | head -3
> 
> On stock 7.2.11, "timeout 5 ls -f | head -5000" printed 5000 lines,
> 4939 of them the last name (FILE_060), and the kernel logged the
> "straddling EOF" line once per getdents64 call.
> 
> Suggested fix, not a formal patch. I tested it on 7.2.11 by building
> fs/udf out of tree with the diff below and swapping it for the stock
> udf.ko. On the same image, "ls -f" printed each of the 62 entries once
> and then exited with "reading directory: Structure needs cleaning"
> (EUCLEAN). A valid mkudffs image with 60 files listed all 60 under the
> patched module.
> 
> On an error, iter.pos already points at the entry that could not be
> read, so store it as the position. The next call then starts at the
> corrupt entry, emits nothing, and returns the error to userspace. The
> emit_pos check keeps the position from moving backwards when the
> error happens during the rescan after an lseek or a directory change.
> The "buffer full" and ".." exits jump to out_iter and are not
> affected.
> 
> diff --git a/fs/udf/dir.c b/fs/udf/dir.c
> --- a/fs/udf/dir.c
> +++ b/fs/udf/dir.c
> @@ -115,7 +115,12 @@ static int udf_readdir(struct file *file, struct
> dir_context *ctx)
> goto out_iter;
> }
> 
> - if (!ret) {
> + /*
> + * On error iter.pos points at the entry we failed to read. Store it so
> + * that the next call reports the error instead of emitting again the
> + * entries we have already returned.
> + */
> + if (!ret || iter.pos >= emit_pos) {
> ctx->pos = (iter.pos >> 2) + 1;
> pos_valid = true;
> }
> 
> Separately, you may want to consider whether a short tail after the
> last FID should be ignored rather than treated as corruption. The disc
> above is a commercially pressed title.
> 
> Found by Scott Carter; reproduced and validated with Claude (Anthropic).



-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
