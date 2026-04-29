Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76324329C66;
	Wed, 29 Apr 2026 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474249; cv=none; b=GDAeChkcSD2kwMsu6CISeV+mGZTSwaHOK8Si0T0zPSH/Dhz2+fLn6xoGo4slip+Mlgxy38q6Bzjk2zzl6tW6IWTeNFn+6RdChzgsvnKl2rhnVAxuTngJtenGEGY6l+UXAiS4BvXRu6Dvb/JvtXnKHlEJWgSwMXTALRvpdLga2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474249; c=relaxed/simple;
	bh=sKjxPDT3cCkwqkYwaOfWX01AA6hUEUU88KzREvcPT/U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGmhkQNHjD26jer8EX6o1YYVP4NLzTNWwwrSiVnuxDD7B/qP8qr2Tg3Umewlkq2ijwexNbjQQDfdLwBxrJQVHL43G4shNXoSUFV62j9grRaPAqzRY+IWC8WagltI2AtPHko4U67SGg0u0QocbsSgO1oMfZ7okgj0RrlvppSMeS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boZhcbtF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boZhcbtF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC4DC19425;
	Wed, 29 Apr 2026 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474249;
	bh=sKjxPDT3cCkwqkYwaOfWX01AA6hUEUU88KzREvcPT/U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=boZhcbtF6gWOq55Hl2a9mKI5A9ohJd2ajTvC2DY0Bg+a0SPYCbHSyN8s6FbaQiT6C
	 LeXllykz5mbAfuzegP3y02e1JjxEQ2K37FQSJGtgHR32Tu+FTYmD8PiCNN5eK4AVA3
	 /npzI2Jcj7gZ9ft4N7vzoTPBtfBMu8fj9gaW/12zKSBPPgEBAQf3RTQVaBZZ7LyFtI
	 l97pzFaCmQoE6zFOkLSvaQf8fn6cpfX0fQiJ2bMeBOkGGXM4SzLSwRgOpaNeH6sKGe
	 gYTS1vnCU5G6FRlJy5vtIcQqmFXQlnoSedgmR50hHdX30najt1/aJ7HqbLJGdE0ovY
	 +sxUwKNQqSNdg==
Date: Wed, 29 Apr 2026 07:50:48 -0700
Subject: [PATCH 7/9] example/iomap_inline_ll: cache iomappings in the kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747213372.4106384.15823678423024531104.stgit@frogsfrogsfrogs>
In-Reply-To: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
References: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Cache iomappings in the kernel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/iomap_inline_ll.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)


diff --git a/example/iomap_inline_ll.c b/example/iomap_inline_ll.c
index bed9855b72a27e..202a528c2735a8 100644
--- a/example/iomap_inline_ll.c
+++ b/example/iomap_inline_ll.c
@@ -176,6 +176,22 @@ static void ioinline_ll_iomap_begin(fuse_req_t req, fuse_ino_t ino,
 		goto out_unlock;
 	}
 
+	/*
+	 * For real IO operations, cache the mapping in the kernel so that we
+	 * can reuse them for subsequent IO to the same regions.  Don't let
+	 * FIEMAP thrash the cache.
+	 */
+	if (!(opflags & FUSE_IOMAP_OP_REPORT) && single_file.iomap_cache) {
+		ret = fuse_lowlevel_iomap_upsert_mappings(ll.se, ino, ino,
+							  &read, NULL);
+		if (ret) {
+			ret = -ret;
+			goto out_unlock;
+		}
+
+		fuse_file_iomap_retry_cache(&read);
+	}
+
 out_unlock:
 	pthread_mutex_unlock(&single_file.lock);
 out_reply:

