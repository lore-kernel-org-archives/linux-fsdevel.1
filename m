Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1A3314AC;
	Tue, 12 May 2026 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588244; cv=none; b=jiS0ElqtnvarsjZ0WapIC1FmkMBMOGc2qKH4Y7j0LyIXbQ3N6E2wxXVgK+tCz26xe080SVNa9h9oaus+IZSH8ubwApPwDNtiazVEcocwaTt3+RBcQ3pKoRcwvU8B0m7XR5mKdiPa8Hxa5L5PvH/7KoK9Tjr4I9OZS5zHrEQQDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588244; c=relaxed/simple;
	bh=fE7NR3x8YOO6IM2Omtk6Wb5FZlFo2i5oBsnFJuMnoZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCaVN0WxYnc09hC8jjCmNZqfmB2JFpuN6q7Wvco5wcmEIEKb/DD50kb3fxHCBf1c1S3PEjl+b6uhMZt5Hh0FSAl3utjoOJGEMqlk//feVxzGdV2ZaFcGStgW740OczQaOhtTMe5NIfD1TVwzcknItbHyIIm+tpWtQ2hoCfNzXMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA36rLS8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA36rLS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EE1C2BCB0;
	Tue, 12 May 2026 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778588244;
	bh=fE7NR3x8YOO6IM2Omtk6Wb5FZlFo2i5oBsnFJuMnoZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RA36rLS8NPwm+ES75fDgkqe/+IXVwJji9/URlF7dzojLG2Sy397O8ewJ4DcftN2vq
	 QfMEKAEmu5M9p94HzcgSrjr+5JlO4gR0RsUZ8fk0NDy+8uDZnGRLeWScEAT5WaKFeX
	 FhZKxWthTNcdjkeCkB6gZRle8NDmk0vAVp7lV5A5eeteBBdInBBqcmD6Mt+8tA3+kk
	 XkFHD2YOa3dRTyyjh3cEZIYznwsEiRGfsmHKSxFBH2xn0TAgkkPyWCrOXZZOhekjb8
	 Wl4S0WBI3FfhEqTCi/bHDuOHlkek7eZYYksOIgcqbLM/f0/trMl3nvi+SH5cHQrj3k
	 S8TX2PSefSTZA==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] namei: use QSTR() instead of QSTR_INIT() in path_pts
Date: Tue, 12 May 2026 14:17:10 +0200
Message-ID: <20260512-unsauber-tafel-5fcd10832759@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505114242.158883-2-thorsten.blum@linux.dev>
References: <20260505114242.158883-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=brauner@kernel.org; h=from:subject:message-id; bh=fE7NR3x8YOO6IM2Omtk6Wb5FZlFo2i5oBsnFJuMnoZw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxS/lLS/qeOyN2nStYVIi53oI3e0O8vHugyM65PTNlU 3/c0t7fUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGCOYwMN3eVxIZpfIvqUb+d 5brsdOSUVNOTk/TtJ6w9vWCz0/WfZxj+lxjI+k01v79Ro9tu341bhnOcDcP2KkzK3XDi/cnH1ma O3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 05 May 2026 13:42:42 +0200, Thorsten Blum wrote:
> Drop the hard-coded length argument and use the simpler QSTR(). Inline
> the code and drop the local variable.

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[1/1] namei: use QSTR() instead of QSTR_INIT() in path_pts
      https://git.kernel.org/vfs/vfs/c/24c62d29e9f0
