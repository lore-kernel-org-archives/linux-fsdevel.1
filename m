Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D203F4DFF;
	Tue,  7 Jul 2026 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421505; cv=none; b=eTTmEEvwBujzw8dLWqMML3meu1LzvQnX7UMizy036OCaQMJIYaE75G9Fd+hhQJx1ZXovxAMAsY21XfLz4MOZi1tN/UeGe/TJMHlzz+Z90TPDknCX32J0JIneLqJQuEmxJb4F5mbm4sTEx/+x/WBjV613ZSSI+WpsmbKxwOUv60o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421505; c=relaxed/simple;
	bh=oTfwD4CLtqqSw4QZGg+rPgsjyO3hBzwlS70gZ/cdI7I=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=MFpYtOoYb+Tpcl4T5cRyVeA+A4Vbx2dp0d2xyIPyM83Iq1G/0x6YqkZIsSTWnBdp3oUaStTMX8U2xlJtZsnBZPrVEO4SCTX0dIp5ezMYjMsrnmkT1T+OrKqzO6DK5kc1xTO2c2jQrL3ZgwEZ36Hp7kEODd7lrhUoulOAHePdyVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YepNvb1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YepNvb1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9811F00A3D;
	Tue,  7 Jul 2026 10:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421503;
	bh=8nXHBNXoD3uAYegM4B+vWHgtEXLobvkQbGQ8j8xhwdQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=YepNvb1Kwr5PGvLTJVcSjxbHDcsqviTDNd3/RvuO9nqEzaDAhQhxAtMo3weKNeuRC
	 hWMc+wlgQClnynTb1GSVH7Qs643fD7xO/DM0WhhjlS+NoFTa0jX1FK1JpgL6TAYs7u
	 z+Wn0eHGPgI/ZJG0E8HPFq836yenhIGta+3Ak+2Euj59qTXzm29scfF8bWqkt8YBxd
	 KsWg+JK0e0I/mMDaTrJnDAHNuGWncaskjQrO61Zf2Fv+ybPDVIXL39HGRRVCe2eo3Y
	 asoWaImE2oMCkdVHISc5BbgIme34b63lXHpJj7w0Wm8avNr7nXv8EcWTHF4IuQvGtN
	 pBis3102FiMkw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 07/14] vfs: move ->create check in lookup_open() to
 before try_break_deleg()
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704164149.3480051-8-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-8-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 12:51:23 +0200
Message-Id: <20260707-antrag-gearbeitet-wertpapier-e6f70ec72bc3@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=495; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oTfwD4CLtqqSw4QZGg+rPgsjyO3hBzwlS70gZ/cdI7I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53DIQjvdl04p7tjW5IKeuKbv56bHFzSJCkVP2Pzv+w
 vXNq1sBHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpFWFk6Ou4YM5krbqovznp
 ybsfv65X9/Dcbnu0x9i7P5lNRsdpC8M/s/W3L7H3T5/FPmeW0NK6E7wnuWd/97865fEl26Mekzs
 3sAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> The i_op->create check in lookup_open() takes place after the
> try_break_deleg() call. This does not match the order when doing a
> regular file create via mknod(2). There the call order is:
> 
> 	filename_mknodat()
> 	vfs_create()
> 	i_op->create check
> 	try_break_deleg()
> 
> Move the i_op->create check to before try_break_deleg() in
> lookup_open().
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Unrelated fix...

-- 
Christian Brauner <brauner@kernel.org>
