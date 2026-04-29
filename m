Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E7E3750AF;
	Wed, 29 Apr 2026 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473905; cv=none; b=dEeNMCfJOKuSgmkfXc4ijS134nLmtNo749PC1Pozt2YqXgTSGluhZsPYXtZ32+r6NSLu3M18/ZpH2BfGRnq+3OgK7flCztPwWIH2+JWF1cdLuU9+Xo52+ewoepoTaYinEyCeO1xJSXfxkSrmRknUvOK2GW0KFP8zZOq4O/xpJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473905; c=relaxed/simple;
	bh=b97Ab4Io7Xb38ixpy5RDfhIyiDD4ry9QWJydkYFKzQc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHCf+fIWuttC2n1AjwQJCKdRCUPzW0qWcB+xyB/Mbnjlb12ZViBlmIwaHT5RNfwssA/k/7ozTfa0q2bQGAKJpdRqhFAoIOi2gH4aTPx6xBZOvwuswULJGkoL7IafIdL8KM7IaQUzIMMuQFEPMH+ae0u+/apvv7kkc+v8UapfGnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0recPT4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0recPT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6168AC19425;
	Wed, 29 Apr 2026 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473905;
	bh=b97Ab4Io7Xb38ixpy5RDfhIyiDD4ry9QWJydkYFKzQc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=J0recPT4c22ecFwcGSjN7/7UuhR6Ivt3yuzPBhii1Cpu7TW4U9ElU0Yak2z+Yum74
	 1dXDUKvl8irf3jVVrhQONF9/ArwvzmW4Hy07YDXVr2Wf8uxQJb3qjMKMmiKhr/XJ5r
	 jHxtORcFymfo6X7A7OVatkWoiHGPfD0kO5G+KWm8HmJBsRyklww4bEvYZURez6fOxU
	 2jlG7YIkT01ManH50TFbWfSXc8QUNxPnlQrhR3n9BeoeSTPcfsWelhIh6NJYz+jYHH
	 MoOUiJ6dGPdbikk2cRlt59cehcJ8n1PRxlIHR3mMijNQyGn4HGrABJLqg2fqTHtnpM
	 6YFrPEmCn0Tnw==
Date: Wed, 29 Apr 2026 07:45:04 -0700
Subject: [PATCH 23/25] libfuse: add swapfile support for iomap files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211979.4104686.14419467379136714916.stgit@frogsfrogsfrogs>
In-Reply-To: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
References: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add flags for swapfile activation and deactivation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    5 +++++
 1 file changed, 5 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 7c34dcf3b90754..0df70d6064b457 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1195,6 +1195,9 @@ int fuse_convert_to_conn_want_ext(struct fuse_conn_info *conn);
 #define FUSE_IOMAP_OP_ATOMIC		(1U << 9)
 #define FUSE_IOMAP_OP_DONTCACHE		(1U << 10)
 
+/* swapfile config operation */
+#define FUSE_IOMAP_OP_SWAPFILE		(1U << 30)
+
 /* pagecache writeback operation */
 #define FUSE_IOMAP_OP_WRITEBACK		(1U << 31)
 
@@ -1234,6 +1237,8 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
 /* is pagecache writeback */
 #define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
+/* swapfile deactivation */
+#define FUSE_IOMAP_IOEND_SWAPOFF	(1U << 6)
 
 /* enable fsdax */
 #define FUSE_IFLAG_DAX			(1U << 0)

