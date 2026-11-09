Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223518;
	b=Xd7jYpSEyMQcNVbzi8jg2OXTUZZI8Vn4bANYS4uIyHHFnx6mxTuRpHDDAOnCJMSzpwyp
	 uKovxxvxV8W76op7pd3k8VhH0gsL8wnBI0TtkrbxA6WuxBBBHPyohwD6DLYBK/FLl+o4E
	 AiXnOSBdLzGTcVsxEnwJDIONqnA7Bo3fUNxo7FKZ8AC/wupoXYxeg8Aq7jKl3DL9Ev3B5
	 DWfkuCj/i0bTAj4v8c4b/nP1X8OyOV6rf/FdElhDnAqbf/vSHRSgauzlq8hYptCE/YEGm
	 swo3rzX7tuNRJeSsRnouifVrkmZE7es3VvGeV8bpGN4lR8kwcGvcEPEDSB5DR3hMq/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223518;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=n1zPFDl2fDt5JEszA0IxWWrN2833H/CzgKPy7g9r5AM=;
	b=GquyipKOQ5ILqZk7dciQYkuD2uFZWRemmg2I6g9GX8/nkAaPSdmesm5+OficOoK1cD6b
	 To4/WZMGNfTAdc5/1gdDIXha8LEPVmQE71nfctFQUR30wDuuHivS+N5T8L9oS9JkLhMN6
	 ohWau76YePcBQnm1NosMl+Ghpyf3/BnyzO5sVXU6H947t9ujhDp5sWjyysijNOg6220RO
	 XJH6OvYPTlpHWSfw5AL8fWH//nhHt87eIq/wp25HDf0NU0lTT2IyJP4EvrPSnpK3Z6Pl5
	 P4K0e/3CRXu0hgY5ne0U1xv9hfJg+CS3hyzIXysyyPxhyUyGqx47o8yk+HnWu2Dff2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bf5tqLNZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141E606A31C;
	Mon,  9 Nov 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bf5tqLNZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC381F0089F;
	Mon,  9 Nov 2026 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794223517;
	bh=n1zPFDl2fDt5JEszA0IxWWrN2833H/CzgKPy7g9r5AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bf5tqLNZRkpAGSPx9e0rwawSONrXL1QB4ySJFZQtilFLHWlDY7D4bzq0n+jtvpyJs
	 YhV4Afg0ZeEN7TGXZ2Z/RcpvlUCPGFu+0nBOP9wh/OxwWeUoc5omDcFStUx6CKTtbF
	 lTJ5jomlAV++QPCw8MEIWSgpR9fLCV1+zZgu7EW25VfJ96+2o6UkAqGmeIt8NOp9SU
	 qCG6RkWanN7TlrI+rkzRiL5Nji+A2Zl07H+5QUjlFTfYgOSD3Frm3sw6bjSRM/Oro3
	 fPoa7SBcL2jknydo9sAX/9gzQjHvdxTla80a4DyQDmLN1gXTfX3GAS4mfrThArqamF
	 SQnzOr/2KOgIw==
Date: Mon, 9 Nov 2026 12:25:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
	Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
Message-ID: <20261109-zahnarzt-beseelt-spontan-7593c02dc33a@brauner>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
 <20261104-allein-bepacken-hitzig-5e517d3c129f@brauner>
 <20261105-genehm-dachrinnen-infusion-9cdf4868d32e@brauner>
 <CAHk-=wiBsoUD=_V3vQr+sgArezxdk0aVk+_8yTX+gK+JVyNH+w@mail.gmail.com>
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
In-Reply-To: <CAHk-=wiBsoUD=_V3vQr+sgArezxdk0aVk+_8yTX+gK+JVyNH+w@mail.gmail.com>

On Fri, Nov 06, 2026 at 12:03:37PM -0800, Linus Torvalds wrote:
> "pos" should just be loff_t, and "size" and "cnt" should be "size_t".
> Those are the correct types for those things. Not "unsigned int" and
> certainly not "int".

Sounds good:

--- v2/drivers/pci/proc.c
+++ v3/drivers/pci/proc.c
@@ -32,7 +32,8 @@
 				 size_t nbytes, loff_t *ppos)
 {
 	struct pci_dev *dev = pde_data(file_inode(file));
-	unsigned int pos, cnt, size;
+	loff_t pos;
+	size_t cnt, size;
 
 	/*
 	 * Normal users can read only the standardized portion of the
@@ -119,8 +120,10 @@
 {
 	struct inode *ino = file_inode(file);
 	struct pci_dev *dev = pde_data(ino);
-	int size = dev->cfg_size;
-	int pos, cnt, ret;
+	size_t size = dev->cfg_size;
+	loff_t pos;
+	size_t cnt;
+	int ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
 	if (ret)
@@ -134,7 +137,7 @@
 	pos = *ppos;
 
 	if (resource_is_exclusive(&dev->driver_exclusive_resource, pos, nbytes)) {
-		pci_warn_once(dev, "%s: Unexpected write to kernel-exclusive config offset %x",
+		pci_warn_once(dev, "%s: Unexpected write to kernel-exclusive config offset %llx",
 			      current->comm, pos);
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 	}

cfg_size stays an int in struct pci_dev, that's a larger thing.

-- 
