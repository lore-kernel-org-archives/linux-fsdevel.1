Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F2C313267;
	Sun, 13 Sep 2026 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789312375; cv=none; b=modFGLe5Rn1vBwHVTWHhbVyFxyPp4R8S+S0c00MjmBeaUXrBmST/XkJSeUOxR16UIzycNtAh7/cBPwpLDSzivOvI0sHgjGWmblbWtDJgOEvU8HpAaBcLc2FGpFh69h1CkaAj9IlzAzw2thTwV+c+S3vSrNfsJqS2rkP3hQTpDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789312375; c=relaxed/simple;
	bh=2H9OJSydwFT0QNUjpsXuje0raC2FTKb22KZ38jpcIec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf/LUD/HC9VWZDMke7fKI/5gXNDNkoHJPCIBR4wULTQ6QuFz3ouxIy0xRT44ZovlMK+Fq0gJrkGIGzu8+ycYLmTEFYI2cumvLWoid0KBFQ+j6xsv441gsOifDq8iz4HPNOxMhOQWASwjI93PbWFokrkloUPSo4Hda1SYF5UnSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=xuloV4OI; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="xuloV4OI"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D25F514C2D6;
	Sun, 13 Sep 2026 17:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789312367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QEd+GWAVv70/aKemk+jvfc/Ph6xxglvtYq0FXfobNZc=;
	b=xuloV4OIoCLh7Bql1n961TUSxSFIWBwCZAhc/jS591JBVIRaWod8AZBq9la+Ybsj4NIAo3
	xIlTfo/KQ2rF6qDOlCUJN8d7wE95O4magF7IejTlBzxSOtgYX26k1WiQDLGaoSdT4PTJQr
	ibmWvhx74omMURs6CsRlcpgYHNIMEoyN0B7xr0/nA68kUV3PLKJny37IKwxs6mbuts7rhO
	GOehVbynQK67P3URBzmeCBf3kgyEBBSeDDvfCM9WSZO5yQfbKBeog5X/S5GHe8VdIEoAcZ
	vDhXMiAP8Fa2W6Z5eu09+SV5ZpCTfP6XBth8bbZlEFj5Jc1reovJbolbcQW8Qw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ef2183fa;
	Sun, 13 Sep 2026 15:12:40 +0000 (UTC)
Date: Mon, 14 Sep 2026 00:12:25 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: hoobnn <853555@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, v9fs@lists.linux.dev,
	linux_oss@crudebyte.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	sripathik@in.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] 9p: dynamically allocate directory entry names
Message-ID: <aqa9WXmrgd_P7yxw@codewreck.org>
References: <20260826064819.52523-1-853555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826064819.52523-1-853555@gmail.com>


+fsdevel@ & vfs maintainers to Cc TL;DR:
Should the 9p .iterate_shared() dir_emit files with path
components > NAME_LEN, as allowed in fs/readdir.c verify_dirent_name()
only enforcing length < PATH_MAX, or should we skip any such entry given
nothing can interact with them later anyway?


hoobnn wrote on Wed, Aug 26, 2026 at 02:48:19PM +0800:
> p9dirent_read() copies names into a fixed 256-byte buffer. A name that is
> valid on the host filesystem but longer than that buffer makes strscpy()
> fail and aborts getdents64(), hiding the remaining directory entries.
> 
> Keep ownership of the protocol-allocated string in p9_dirent and free it
> after dir_emit() consumes the name.
> 
> Fixes: 7751bdb3a095 ("9p: readdir implementation for 9p2000.L")
> Closes: https://github.com/microsoft/WSL/issues/41192
> Assisted-by: Codex:gpt-5
> Signed-off-by: hoobnn <853555@gmail.com>

Sorry, but pseudonyms are not allowed to contribute to the kernel:
please use a real name here.


Okay, I've just tried with a dummy server that adds a few bytes to every
filenames, and it's weirder than I expected... The vfs only checks for
PATH_MAX length, not NAME_MAX, so e.g. getdents64 will list the long
file name but then any operation on that file name will fail with
ENAMETOOLONG...
I think it'd make sense to be more clear about this in the commit
message.
(The patch subject is also pretty bad, by the way, in that "dynamically
allocate ..." sounds like it adds an extra allocation whereas it just
reuses the one that exists, so it should be more like "9p: skip
intermediate directory entry name copy in p9dirent_read()" and explain a
bit more how the current readdir processing works in the commit message
e.g. first alloc+copy in p9pdu_vreadf etc)


Anyway, code-wise:
- p9_dirent are very temporary and are meant to get freed immediately,
I think it's perfectly fine to skip the strscpy here and pass the
pointer directly.
- I'd like a second opinion on whether it's acceptable that we return a
file whose lenght is > NAME_MAX to userspace here; we're already calling
strlen() again in v9fs_dir_readdir_dotl() so we could just skip the
dir_emit() call here if required.


Thanks,
-- 
Dominique Martinet | Asmadeus
