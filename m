Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4C1DFD96
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697323; cv=none; b=HlZfkrC+JvKD1Lboz7TKoWR6mj7kAuV6V9qRkFqW90ojJEU5yoOqENgnTAQ1uV1DefrITBigtLlnEoC+C0Q3dBHOIw+kuz1NYQl3Jfl33qTwVGkcIQqLtvafIIzN4VhvVc/kalF30TBVlTVUkk4aMVtWEwlDoXgOElf9HyX7A1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697323; c=relaxed/simple;
	bh=+ahYD3ln/ULvrUVzB6kV7WQ7F2JVz4sFOTGAQ81a78U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDXQx5+/HO56j/vhm+RWSjXm/sEaecB3SXWe/TDNDGp3csFNGqFEdl2bn6JGuWjZMgF7xx+G079e7KFMCeVyC7RalsYJwMCCqfUMkxSDTWRp4+DY0YXx70hla+99DN9rro2zRfuKRypPZtn0bKt+RlkOKEwVfwWrD/d1eUPx+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=v2moqFsA; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="v2moqFsA"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 16E061CBC0;
	Mon, 16 Mar 2026 21:41:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 16E061CBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1773697315; bh=+ahYD3ln/ULvrUVzB6kV7WQ7F2JVz4sFOTGAQ81a78U=;
	h=From:To:Cc:Subject:Date:From;
	b=v2moqFsAsUUe1gvLhrdTHKjNrDKkgniwEOUcGOpr89VT7inNFyQE0VUpSQjPc4VMj
	 AbqteoQZGnnwB1qsUZbVxxBWgJ6iclT3w4iUOnZWLWxN/J+vU/DdzEV6iOLdkn85g4
	 u5Del5aMvrow/Rw2JkG+l0caFi0IS0+lhbISD4Ms=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id eL6KLiF5uGltqAYA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Mon, 16 Mar 2026 21:41:53 +0000
From: David Timber <dxdt@dev.snart.me>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org
Cc: yuezhang.mo@sony.com,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v0 0/1] exfat: set s_maxbytes
Date: Tue, 17 Mar 2026 06:41:36 +0900
Message-ID: <20260316214137.1490070-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Possible security impact when a file in an exFAT volume larger than
16TB(MAX_LFS_FILESIZE) is mmap()'d on 32-bit machines due to potential
undefined behaviour in filemap. Though the attack surface is quite
limited as mmap() is rarely used with exFAT. The comment on the macro
definition is pretty much self-explanatory.

The use of unsigned int became apparently evil ever since Linux
switched its own loff_t. Integer overflows could go undetected.

David Timber (1):
  exfat: fix s_maxbytes

 fs/exfat/exfat_raw.h |  1 +
 fs/exfat/file.c      |  1 +
 fs/exfat/super.c     | 11 ++++++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.53.0.1.ga224b40d3f.dirty

