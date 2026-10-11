Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3D13B5B3;
	Sun, 11 Oct 2026 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791757022; cv=none; b=aPOUd1HbaosL9RBV4t6grm1QrLS18kmqfIg4s6e4Hok16Lq7u6q3ywDTVVsKffcEZdpvP4rdLl8JKEPdDG2SjbV00ZoZwKuwoqCn8XM/k+IUFFku38fmfqfw5ooKVkwBi5cYW5AWjTZ41n6bXLTKQ3tu3rWr7e5pigdl4duRcwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791757022; c=relaxed/simple;
	bh=CgXG61SZZ2ot7qEKeHn0K0CQsc0qhHXWWLexLYdUbFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDj8lVpTQDM/qqEP5qdbHBKuCU8f7kDExOoogdjGqORX2U0JxVRtvkNmD5MBVHmA+c4kvdaqrckf38dX8GjXLNCxK18hiYcoRoe5ZxCJbweZYBJnvAxVFxFKxxvFX73nGn089SU54x/VFIGQS/41FMQEEi70OaTGbcRkHxYda3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv4jwxgl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv4jwxgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A29D1F0089D;
	Sun, 11 Oct 2026 22:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791757020;
	bh=gNclRxy+ACNG9XMox69OukjyzUaA6/YzURH4uN4Krj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dv4jwxglXHc7R594jMcwKwlX1B27EoJkFXQ4vsniLFE4bLk2PkvwY3XBo9bsd7WX5
	 aBJivQU8T0zPGRk49bBLaxD+/7zEGGOnWvq13x1ey/lYI0+c8iVzSDMNuaMrVwz0yB
	 1FFbupMAPcSpLq9E7oAjFmDkV4xz+RCDg5BIecfCe5ucUwvNccxMNHxn/iYjxAma9b
	 pNtIM55x7fEGIwnH2deZ4uN7Qm2n6B+pG2bf71bV/IXtEc5DxZkXb8r3Mw4FoVjtMh
	 ULEIza8d4Xbw8iGNMKHiVt9EyU5HVNNYcZ9xebQyxYHmxmETRLfoAMokFmVYMEk0//
	 HuLkPuv5d3UzQ==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebastian.n.feld@gmail.com,
	cedric.blancher@gmail.com,
	Lionelcons1972@gmail.com,
	charsyam@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 3/4] MAINTAINERS: ntfs: add UAPI header
Date: Mon, 12 Oct 2026 07:16:47 +0900
Message-Id: <20261011221648.6811-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261011221648.6811-1-linkinjeon@kernel.org>
References: <20261011221648.6811-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

List include/uapi/linux/ntfs.h under the NTFS filesystem entry.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc3cae2e378b..b035f7ad34f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19489,6 +19489,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git
 F:	Documentation/filesystems/ntfs.rst
 F:	fs/ntfs/
+F:	include/uapi/linux/ntfs.h
 
 NTFS3 FILESYSTEM
 M:	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
-- 
2.25.1

