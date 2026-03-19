Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF88313E33;
	Thu, 19 Mar 2026 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915508; cv=none; b=Wy/yetgQcaQqvhLe/Pch+VP64z6MKeFcPTfs39rW5RC3aLifvpUvxMhU/kYZk3mnMgDe+Znml/SPrg34k2jmTI9nkGyMrjdUtL8e0Mqm32Wh89nUQBu3aEXXWHlQeWK8xVsQcqF60AiQCo6gr6OECy80QnEYfnnrCdDJMoMwbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915508; c=relaxed/simple;
	bh=TUEVOHWTMSG01UQGMUtewYqqcPf2N+JhnDRE/9zJSvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Or84PdJgrha5Y4FwryWfzK1Xu4//r4Omx1BCes65w9Iv/NuYrk9SIaPc59/DEESbNO4XEkUjSGee3wmEcD9LfGz9qA59g6kOdmDWXSRfsNxEF6iDoLf13ffhsdhvJUEhURwEQS6O9hY6msWhg/LNyRijPp2zzTYIno3oChYwUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQSORDY+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQSORDY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C776C19424;
	Thu, 19 Mar 2026 10:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773915507;
	bh=TUEVOHWTMSG01UQGMUtewYqqcPf2N+JhnDRE/9zJSvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQSORDY+x7I+b68VhfQNU32a+ozdUUkqD3Xm50rCGyTvWaM7mmhbN4uRLvFCfRi9p
	 Vw7PO1gmSCW4yXG29fNmogFHV/yWUSpZ1J+yCHxH3XkyRUB+tXEsoVYfu1P8ZktqCV
	 Z2Z5frHf3M7w8c9Nc4gNwMBpa2INvTlDiGfb7QpeWXTFSd2doIAReZYQCGTz+WZ6VC
	 srHNM36HKdvPwruJNUmmDIZ1nh+rF7ZBCmNE/17yEMJRHmioFhAtJ8GgkTTy/VV9ju
	 v6qwlxo3sjf1jYG0hJXvD1yV3IXFWc28wo0LcWoRRfyVedYnlArtlFpR+/E78gtUT6
	 WtgORBwhIgCNA==
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] vfs: fix docstring of hash_name()
Date: Thu, 19 Mar 2026 11:18:12 +0100
Message-ID: <20260319-zumindest-norden-3b47a099c1bd@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318203953.5770-1-jkoolstra@xs4all.nl>
References: <20260318203953.5770-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004; i=brauner@kernel.org; h=from:subject:message-id; bh=TUEVOHWTMSG01UQGMUtewYqqcPf2N+JhnDRE/9zJSvA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTuPps/fV2nTnP+nIU+R1/vEHy6Wfar6ilLjecKsYu6d 9bdEFYp7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIbRQjw4M/4tuCC+e5ceer l9++2Wd1IP5Fn/MC54mtM55zLre0WsrIMHPa32CVFyG7Lk7hXeFbVe3Sxaistp9XQOnDhLbLE6x zGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 18 Mar 2026 21:39:52 +0100, Jori Koolstra wrote:
> The docstring of hash_name() is falsely reporting that it returns the
> component length, whereas it returns a pointer to the terminating '/'
> or NUL character in the pathname being resolved.

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] vfs: fix docstring of hash_name()
      https://git.kernel.org/vfs/vfs/c/8fb6857f2f5e
