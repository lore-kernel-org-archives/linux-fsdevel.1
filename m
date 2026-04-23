Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F7829BD8C
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979998; cv=none; b=Q7/StQyG5k0cfwevEVAf498K5e4V1yKaASmw0wgMBM01GiaqD0oS2Xjir+h89L/Dyp1dYnN0tuYC/g/BXdzc20heViwmuPuZu6AaOFGTFXue8MqawSDAxtGfNiebh9gMt/nujFsTYPLctcojy2KDhvKqdIXM2gDsorIDis3me7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979998; c=relaxed/simple;
	bh=20g2bmSb9uKCnTGwH62A6XR3YrA3EHfz0VGGQ3CAbhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rl7cKlaHFIa/IFW9AZN7JdsXXtyA/Pp9naur57S6I1mJBik5ppGJD6Xm98elXFSog5FC05A3sXRCOn0pQF2YYaM4rg+BTQe/n6mpXb9lvDzBulQD33OElNb/k8uWFfE5NHI+/gcZ2GMDCVpX0vu1Tv2ic5KLEuNT+9s0AzdWDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLQLH0m5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLQLH0m5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482BFC2BCAF;
	Thu, 23 Apr 2026 21:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776979997;
	bh=20g2bmSb9uKCnTGwH62A6XR3YrA3EHfz0VGGQ3CAbhA=;
	h=From:To:Cc:Subject:Date:From;
	b=oLQLH0m5/ZswSawLH4WSum8mDEbQR3IU3xuQ8YzCKxDjqWhN61osdB+bx6MgkIp3U
	 rWmBAhygmXZMuhcvGLjXQ+hW4RbkjvkjI2idWIIUUn8vngspe6zaPp1RbZpbE1IV+D
	 bPCOHrDufb4RCqus4plmdvIyACRSpFRjpQ3MAgRQm8NIjV5Euyfad6Zv7SGAwE3dMi
	 yzvmU+U+rlYpBjttt9Wtd993kRP9kz6gduUDCzT/IlrbCixD+UOZQ3LJn0qytvA7U9
	 Zs7b83aK5zwSFkZA9+vW7XAfgY6wekpl8OucR9CRvI9Kdr0AfZC1DrWPAyGrPcglPm
	 nBu6CwIs5CRGg==
From: Namjae Jeon <linkinjeon@kernel.org>
To: brauner@kernel.org,
	djwong@kernel.org,
	hyc.lee@gmail.com
Cc: willy@infradead.org,
	xiang@kernel.org,
	hch@lst.de,
	linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 0/2] iomap/ntfs: remove over-strict inline data check and optimize ntfs
Date: Fri, 24 Apr 2026 06:32:01 +0900
Message-Id: <20260423213203.5533-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series aims to remove an unnecessarily strict boundary
check for IOMAP_INLINE data and, as a result, optimize the NTFS
driver's handling of resident attributes. The first patch removes
iomap_inline_data_valid() and its callers in the iomap core.
Currently, this check prevents inline_data from crossing a PAGE_SIZE
boundary. If the filesystem provides a valid mapping, iomap should trust
it regardless of page boundaries.

The second patch updates the NTFS driver to take advantage of this
change. Previously, NTFS performed redundant page allocations and
memcpy operations to ensure page-aligned inline data. By removing
these steps, we simplify the NTFS iomap implementation and improve
performance for resident file I/O.

Namjae Jeon (2):
  iomap: remove over-strict inline data boundary check
  ntfs: use direct pointer for inline data to avoid redundant allocation

 fs/iomap/buffered-io.c |  1 -
 fs/iomap/direct-io.c   |  3 --
 fs/ntfs/iomap.c        | 76 ++++--------------------------------------
 include/linux/iomap.h  | 10 ------
 4 files changed, 6 insertions(+), 84 deletions(-)

-- 
2.25.1

