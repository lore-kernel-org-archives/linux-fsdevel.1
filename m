Received: from mta0.migadu.com (out-207.mta0.migadu.com [91.218.175.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA614AE118
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442024; cv=none; b=L0BL6O9DXducPsiDzigfkRxkuQ0aTFb8neg584gKJZ5sO7qaJTfdZC9l8d8M3P9mjKFA+xbwBtTU1iDcoIipHC9i4iRjhw/IiSkea2Zue24JzvdbZjL6Evt52j7nsB5ZffC6B7+GLx7OCKLSy93BYegS2VoNw8rqgz0djaSsvxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442024; c=relaxed/simple;
	bh=EaFcC/RhSenhJN9ukgjvjgGtZu/yLECIcHxTsatpik0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKHPak3Ljt6uhdmeH7Ady8HUZgh0+17ZKRx/w7HMr8KDcCjUfj4T7L6Gss7KJZkdKF/pQO/3TpFx891odh7Ytnys5sWVYtNEB+P0VrMRJENak68I8skBolISeU7rNxHTUmbq/jU/11YmXjt15C9dbTp2PbwD49uvG72ddH8qKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qwFxnSA+; arc=none smtp.client-ip=91.218.175.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qwFxnSA+"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EaFcC/RhSenhJN9ukgjvjgGtZu/yLECIcHxTsatpik0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788442008; v=1; x=1789046808;
 b=qwFxnSA+mYcq61cDrRU/N1+DuetQ3QYbXMH69s9yxU+uZoqqFpTF5SIxctuaGEr/GKvrCSaR
 OBHVYuq0Ma5ez4ccTh57pxiUIlseqUVHyVCUZq2vdp4kAZ+5f9qQZjdc6RLCTN0uOsoMGoy/4vN
 ePeV9APMdGmDj4N6bKtsYg5A=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id de941cdace52f3fb;
	Thu, 03 Sep 2026 13:26:48 +0000
X-Mizu-Trace-ID: de941cdace52f3fb
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jlayton@kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2] overlayfs.rst: clarify the scope of file locks taken through the overlay
Date: Thu,  3 Sep 2026 21:26:36 +0800
Message-ID: <20260903132636.1113789-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

File locks and leases taken on files through the overlay mount are
only meaningful between tasks that access the files through the same
overlay mount; they do not conflict with anything that changes the
underlying filesystems directly.  Add a short note to "Changes to
underlying filesystems" stating this scope.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
Changes since v1:
- minimal note within "Changes to underlying filesystems" instead of a
  separate section, per review (Amir Goldstein)
---
 Documentation/filesystems/overlayfs.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 16c35b491dad..11af5bc73e32 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -671,6 +671,15 @@ filesystem are not allowed.  If the underlying filesystem is changed,
 the behavior of the overlay is undefined, though it will not result in
 a crash or deadlock.
 
+Note that file locks and leases taken on files through the overlay
+mount only provide mutual exclusion between tasks that access the
+files through the same overlay mount, and a lease taken through the
+overlay is broken by opens through that overlay.  They do not
+conflict with locks taken on the same files by anything that changes
+the underlying filesystems directly, so file locking cannot be relied
+on for mutual exclusion between overlay users and such direct
+changes.
+
 Offline changes, when the overlay is not mounted, are allowed to the
 upper tree.  Offline changes to the lower tree are only allowed if the
 "metacopy", "index", "xino" and "redirect_dir" features
-- 
2.43.0

