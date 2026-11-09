Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223589;
	b=Q1ZQN/snMTORmIH6GdzEbxSeQJKXk+j86tGAiTahwVILakuWVIQmlGk5OjjtSW88IV48
	 PJ+DbUiJur6FfoELkAahL6DJIIO2wOq9AUXroWg1GbhGIaxNshKA2lVrJdHKGe80wjYsF
	 l3pkKt96iJcy7zFEe9EpepiUVzkEC7tv5+mlppxZ9Y4ftC9/AwTwbRcx+1FsxyIgoOv1r
	 sdD6KbzQLdJKoPj4F4Kwi4wzHljbuDO1RNUhrz0DQMFf1Sw2bK9bJ3OoVspWXnXAh4sF9
	 IH71QS5f3noS0BBMVQV0hxRwUVgp/RJhvHUO34OrgcXHujfyKUYodd/gcp959thVeUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223589;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cWiIJfTA4m6YoCnpWTMnm48t+HL+VdqiKbJWu4IPPdI=;
	b=ixdPBnsTxKh63Yxo+UxkXgj4TtjBC/sxOgTPU35bLUIkfudeoxs4S28hfh9Sz+2ECNhf
	 lDYg5VbfWsJvELFHUkMED3fQ7FUs2jSlVxMJP3n6++l7o256wjuQwrZcPmYLYyv3wUK/G
	 GIwxI5Kt9p6axwkewKnlM4jGdnXFrTOuDvTucVtAXUHHkUrlK7J+B26HVHshF4dlz8wvo
	 8tCICZovpjFWvZxNwOlnaImFEmEpFemaCBcm14H6yyEaEI2/vlmfbGTbsWFK5SxV9DqX4
	 lmGYJSHjFcY86A4TzxA720rszTfAufe8TiHmjrIsRKEJaZT/hv6SmETKk8E7am0W3SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWSP1RPk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B029606D808;
	Mon,  9 Nov 2026 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWSP1RPk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464561F008A2;
	Mon,  9 Nov 2026 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794223588;
	bh=cWiIJfTA4m6YoCnpWTMnm48t+HL+VdqiKbJWu4IPPdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kWSP1RPkS24dEgDNYv4KYac7avJsXtouTvBsfatKfIdfsE80vvUnsGPkW+9Q/DyYd
	 KkpaXRymRGAeUcF1lSPxl7VSDidJEpOzaBEOKNe6vlhN2E40nn51Wexa0Ce7z0zzW2
	 dF4s9veVnpkPUIuMxUqkLzzsmM6PNMuZ1tq77xRs+u1jFWqr7BgWl1QTsM3NN1fmQ+
	 f480dlqWSngyecHYbh0xThW6uaWLYGsAB8PJzknCFTYY5qIXHPnq8ZNcmfgI1/QDQ6
	 jeKQEefd7e69ETCCvYM33nKDf+j4OnGsE0DqDVmt2UanVUARZ2DErNo8oJo2rFEILF
	 3uu2anWcXkbvw==
Date: Mon, 9 Nov 2026 12:26:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
	Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
Message-ID: <20261109-hackfleisch-lohnt-konkret-02b5f3dde4f6@brauner>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
 <20261104-allein-bepacken-hitzig-5e517d3c129f@brauner>
 <20261105-genehm-dachrinnen-infusion-9cdf4868d32e@brauner>
 <CAHk-=wgLpWDjmcNWphCMkKXKwuZsa8KWRPvJ4j=C_ktCL4gBzg@mail.gmail.com>
 <CAHk-=wi-B--TBQuYjz6J6vKtEMpNSm4_wVRzTP_vE=uTLb7P5g@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi-B--TBQuYjz6J6vKtEMpNSm4_wVRzTP_vE=uTLb7P5g@mail.gmail.com>

On Fri, Nov 06, 2026 at 12:19:45PM -0800, Linus Torvalds wrote:
> Ahh, this all goes away in "scsi: core: let procfs copy in writes", so
> never mind.

Yeah, but we can still do what you say in the fix:

--- v2/drivers/scsi/scsi_proc.c
+++ v3/drivers/scsi/scsi_proc.c
@@ -66,24 +66,19 @@
                            size_t count, loff_t *ppos)
 {
 	struct Scsi_Host *shost = pde_data(file_inode(file));
-	ssize_t ret = -ENOMEM;
+	ssize_t ret;
 	char *page;
-    
+
 	if (count > PROC_BLOCK_SIZE)
 		return -EOVERFLOW;
 
 	if (!shost->hostt->write_info)
 		return -EINVAL;
 
-	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (page) {
-		ret = -EFAULT;
-		if (copy_from_user(page, buf, count))
-			goto out;
-		page[count] = '\0';
-		ret = shost->hostt->write_info(shost, page, count);
-	}
-out:
+	page = memdup_user_nul(buf, count);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+	ret = shost->hostt->write_info(shost, page, count);
 	kfree(page);
 	return ret;
 }

-- 
