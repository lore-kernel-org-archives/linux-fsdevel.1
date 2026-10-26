Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032796;
	b=CArC0Nmi9CAv6KDfbay3MVFFl09v3Q9bhHx4BhXZHKXsVbEc7K4yNlQt2xxyhVIFAFGC
	 64cuwFASeVANb/ylVYA8PHBBWNDvRJZQpPRPy3vNFZJT+uxUW6faHDeOolf1GCx/JIEKE
	 ghEeXS/A9vVdlB9M152YeZ0P+6DxOCyvuAiytvCOG+M3cVyCfp+4GTm+aMYuurhZ2m7nD
	 8kek9tVULi7mj+TN8Vn8abauxwdp6aZZrqFqvkUPLrJ6m5kzSafJ14vy9abo+VdIh1xKf
	 JfWVsdVV+ZwQm4K72KVhHipW2juCbTKTvbvKFw+7lUvGLyTKnV5sNu5RFUJZf597DkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032796;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JglIsJd1kXI0nJZQK2Xa/uId128Ep2Ubg69nwdzo0z4=;
	b=zFlDdhcwMc6f9MVbIZIBtbUFMw6lZhPTm3eyOO/7jlsV3dLrzEHi1ylA+FKH113uhsdE
	 orNfLAvCGrJuiXIaOXV2NP7vEnzbyyXV5RI7uuY7MUt1V1d96L6TSi1Frkdg3eGiGjE9v
	 lx8+uJbbY1wMwP+93VhsIHzR8tkaVf+2frxCT7WMnxDanM45cGKL2xWSlI4xfiKBxy2EI
	 j0ev/IhU3cf/beK84nczlUrQ+PY5pNN+nJ4PXTnoA3a8UeuR5wcMEdxaKbyDgFdR+Vc0Z
	 7o+fqI3zUCisLAZELd8hXhrzfTktUEuq0wGptu8Awgg0I0fHtt0NqSu3okDkHeD9O1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=4EDv88mm;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7A606A332;
	Mon, 26 Oct 2026 16:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E7A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=4EDv88mm
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id EE9A61210EB;
	Mon, 26 Oct 2026 13:39:43 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1793032785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JglIsJd1kXI0nJZQK2Xa/uId128Ep2Ubg69nwdzo0z4=;
	b=4EDv88mmVOlraww5PuWEkO9IVaq7N4jeeLSc2a/ZKO3XCKAtts4J26coCYGDn339o6LuAk
	cn3sNYO6Umzs41uEti8ogi4NZJ/ZK6GRdUgw5bUNTk/6dSffh7w9hmR5YzJ814OF27ilx4
	cPc10ROVuTxcyv9T8s4xFwnU4YoES9ZYpZxgB4EpdD+YIE8ZbtggLM+Ggvh6qsozxefzYG
	t6mGz1qvgjFtX2AEV2HrhQ4pOYZVOYrcs/RcdvBMcOq+I328eISZ1aZWzDoqRvc1nxRnm/
	jdzeoTM9h6bKafU1mNIUA91/+1MyzarpO1M/V+Tw1PUb/Tgp3+g8DqosZaqB9w==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH v2 0/2] fat: improve synchronous mount performance
Date: Mon, 26 Oct 2026 13:39:39 -0300
Message-ID: <20261026163941.495833-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series improves performance on synchronous mounts by batching
FAT mirror writes and improving fat_sync_bhs() submission.
 
The benchmarks were run on top of my other FAT allocation batching
changes currently in linux-next.

Changes in v2:
- fat_sync_bhs(): make err a local variable and return early on error.
- fat_sync_one(): make err2 a local variable.

Thanks,
Matheus

Matheus Alves de Almeida (2):
  fat: batch synchronous mirror writes
  fat: improve fat_sync_bhs() write submission

 fs/fat/fat.h    |  1 +
 fs/fat/fatent.c | 80 +++++++++++++++++++++++++++++++++++--------------
 fs/fat/misc.c   | 14 ++++++++-
 3 files changed, 71 insertions(+), 24 deletions(-)

-- 
2.43.0

