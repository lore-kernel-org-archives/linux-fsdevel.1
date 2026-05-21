Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063803655D1;
	Thu, 21 May 2026 03:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332818; cv=none; b=kQjDLI6o9C6mp/zGElxFLF9Ils+Bpp+cQJU8IjCkcj3pS2XOx3CLOZ72GzpsIOKOP1joK2sDJNqe2GAPtGFPWnPX/TWzgb3WseOBoT8nsGe9jqmpLFxS8ekUdlM8WDh9UbIZY69/Mmar+eCFiUUBVW5uwIJgdD2sOxx787MYORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332818; c=relaxed/simple;
	bh=c/KLTUHbl8daUS7RfcUK+26Pchf/YuSZA1LW58NeHJg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4MKmLPB1r22BRirwQOhp7MjN2NmbLWsPxqbEKGZ/ek9MCWpjaIdvwOoVmE1nXovA5Woq4f9fg+SrhOODneCqpGWIIEx2nAp9stZxfJkzooJWUCKL6TE1RtnGF7bcVrfzwgQS/h5V4MIh6Ga1THwBwjPpK1SC1AtZ5q9yfhfpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn/CFLe/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn/CFLe/"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 237DE1F000E9;
	Thu, 21 May 2026 03:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779332810;
	bh=/TgKoPUxggrCr+/+EXRsMLuBtqeZfvw/7KaqPN9hGoc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=Xn/CFLe/L95zt5C8XKR8f1vaXCk/XfnFOE+O6rh+cgAuACWlvwr0JGTrtCetes5dm
	 wkG0UlRf1xbCzzcNf0Jrb+Zi3fLPY3Ec74aerWA3iBTstd4ch64xnJceEIzARj6PM4
	 smdak0yQSp3/qnOg/HcwvMWTdamt2B0nAL99pX2XZ3rkVibxOF95fVj2zKlQ2GAcCa
	 vGzhTGME9LUOKuwjOY8i2GBMNYNjZl5Gx33dFfywMf506EjjHQ9ndKDDW/RFl210VA
	 1qNOfnZXZcosmtFLKJU5g82Rwh6IiVx688A5trMTysisezbrx1JGAFRPK2SV8EGB4B
	 WvvxvSuswvzSg==
Date: Wed, 20 May 2026 20:06:49 -0700
Subject: [PATCH 2/4] mount_i_linux.h: fix whitespace error
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: joannelkoong@gmail.com, neal@gompa.dev, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Message-ID: <177933241483.3536631.14014212409440427887.stgit@frogsfrogsfrogs>
In-Reply-To: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
References: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Fix trailing space.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount_i_linux.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
index ffbdb7deb894cb..3aab935438837c 100644
--- a/lib/mount_i_linux.h
+++ b/lib/mount_i_linux.h
@@ -81,7 +81,7 @@ unsigned long ms_flags_to_mount_attrs(unsigned long ms_flags,
  * Read and print kernel error messages from fsopen fd.
  * The kernel can provide detailed error/warning/info messages via the
  * filesystem context fd that are more informative than strerror(errno).
- * 
+ *
  * @fd fsopen fd
  */
 void log_fsconfig_kmsg(int fd);

