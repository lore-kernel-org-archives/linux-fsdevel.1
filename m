Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682544A3F16
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347374; cv=none; b=REptBR61GIJhh2PUXoudqwW4L5u8IyD2jCEpYF6gFXamy9uhyMHp2SpMKawGHp14MQEZIfQ8XvDU/0c7V/EDhMEIbDJ4VX7Lo7y4MN/8B7YIDSa4B27NrYAkYyBbDrtVsLvTCfRuSOdOHei4+Be7wzN907ktDhlAUns07X41ca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347374; c=relaxed/simple;
	bh=CuNDwwoOOY9fkVtqEtRpuHs85kM0aUdxca8mk5TrIm4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gfDSck611s7VrYTpc69NxfE00Nrdew/JDqwaHXpFMuxGA2AcitQtXHPVOhGuQiun5q9+iwJES75/ws6FEiCpUHPwospOCPY/mSs/REsLAbZT+wyd06I6A+A2L6Mmcg2UlwPW3DX6Ks1QTc8mzmgtMRLLyWSyHQUJKnwFUejcIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMFjXsxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMFjXsxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531891F000FF;
	Fri, 25 Sep 2026 14:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347360;
	bh=sGv0UBYvRgNcSW/58ll0u5Hu2KHyvQaa5V4ichkDdRc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eMFjXsxiB0AHY8deYS9wvLYSTFQfsSjicYh2otZljv3eyajQSioUdaNMwCRQqNaSj
	 tV4JVhSrkva5AwCYjJV2bBtTezOLH9DgqE1H5za1k8A5XxXle8MGzbY4s/n2jHUpWf
	 hjEGIsyOwIBvueD1XDlQq3wNT8q5QzgFamhtFwrs+hVyap14GKhgELrA41I0EuNJwz
	 nfh6HPRAKhOwKpFuTEt0DUhURLCn6DbMo8O2Muxkou84xx6YnyA2EFwNzY8jIbJxVO
	 dZf6iMBo3U4HI+xZELw7/7yW1J5feiU507GZKDcUAnIoiIYgHOu5pwWTV7Cy20vtPV
	 oVkCTfPFHdWKw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, hubcap@kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>
In-Reply-To: <20260915162637.499735-1-hubcap@kernel.org>
References: <20260915162637.499735-1-hubcap@kernel.org>
Subject: Re: [PATCH] orangefs_super: don't wait on service operation on
 system shutdown.
Message-Id: <20260925-alliierte-beistand-treten-9eb8ca2ecaa2@brauner>
Date: Fri, 25 Sep 2026 16:42:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CuNDwwoOOY9fkVtqEtRpuHs85kM0aUdxca8mk5TrIm4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRt64hdKxr41LP5pvKyqbbrppx3Ejj0aYeeUcrPqocvl
 6/OsfhyuaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi680Z/jtxBvDJveQLdmQ6
 df277I7LToGyXcn6F549286f1l8W0cjwP+Wsfe7X2X5civGlMicTGhvW3qo50H56B3fA9rWmKbH
 a7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 15 Sep 2026 12:26:33 -0400, hubcap@kernel.org wrote:
> orangefs_super: don't wait on service operation on system shutdown.

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] orangefs_super: don't wait on service operation on system shutdown.
      https://git.kernel.org/vfs/vfs/c/6c21c52cea96

