Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B09E41B36E;
	Wed, 17 Jun 2026 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702486; cv=none; b=Qi4kNVTTUUTvKUJmXOtUApQqCrqrbwDp2x/VWkmFLDLnbRjMki/2YPJ5duRBSo0Clfou2UybpQpXAICkFJaAap1Rqz7+/8BQ8WE83VyX5meNlKhYWpupX4QPUbVSa6cCv001q3lPdH3LjDe+YURN1t/ExOecqb8VmmL3LJaGmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702486; c=relaxed/simple;
	bh=m314LpSljxffpgIL67NbEa1HaZsA07ZUvVbY27TmbzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTU+mSFpdW71dBuLpDpgE5wams4o3R9cRvZK0WCrC7MyHwwT0jMtCvATWKWLdqk1kla4XSIv74O9uKbgB+VjDfgxECuLHztTHMNJ7NlxnmUVwYVRLqvpzsm13L3rVy7kBMizMoFeXiYu08t7y3KDrS9rXIuwzrt5BR01XXqhPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK8fh41u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK8fh41u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B515D1F000E9;
	Wed, 17 Jun 2026 13:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781702484;
	bh=KatzPeqYH1K3FNjb9zFLVXyQM8JD6zV1FG1wHzHJlNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PK8fh41uTl1EooOCfOmezFCxp10oM7AMfTJ6xjXZaHVtRzUi1GyzU+ACxwQDEQNRO
	 V7W06D/K8in1k67oL19pWAbaDad+Bjt2ZjFjDsYW0bYC0BaSkbNmpg7Fi754pfwO2n
	 KCilfVjIEXQ3fBKkIUo9Jqf5zBMK7Tq9rCI+76YwiZYzYLUFhW7njZ/NsTFrW15c/t
	 kmr9GTCQedrXzfaq+y+AYN0UniXsGciOgN3uGN70W9rHL/NyC4EaoVHVJFufqx4ZN7
	 9ow3tcOTQOX1kcogIUaA2XVRVeWQWbbKuVJFwZFfMKuqLFfVdP/McvZKFKrBVkO6g/
	 7hYjjHyHlGasA==
From: Christian Brauner <brauner@kernel.org>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Wei Yang <albinwyang@tencent.com>,
	Zijie Wang <wangzijie1@honor.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] proc: only bump parent nlink when registering directories
Date: Wed, 17 Jun 2026 15:21:17 +0200
Message-ID: <20260617-zeitig-umlagen-ortseinfahrt-1389d7457b0f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260613211005.921692-1-kwilczynski@kernel.org>
References: <20260613211005.921692-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=brauner@kernel.org; h=from:subject:message-id; bh=m314LpSljxffpgIL67NbEa1HaZsA07ZUvVbY27TmbzE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZzfdXWlLvcT7xx3OzN2sfW2jeuOenaDD3y23RDOvWP Q32TkuzO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayeCIjQ1e2v41IZ9N63cZo yU+qT3+GxyRsa2aXrNy2VymZPcBMmeF/SrmD9vKtgWcemn/8k/VCdj77jjLVpX1WyZzBTd/7oic xAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 13 Jun 2026 21:10:05 +0000, Krzysztof Wilczyński wrote:
> proc_register() increments the parent directory's link count for every
> entry it registers, while remove_proc_entry() and remove_proc_subtree()
> decrement it only when the removed entry is a directory.  Regular files
> thus inflate the parent's count while they exist, and leak one link
> permanently on every create and remove cycle.
> 
> For example, /proc/bus/pci/00 with twenty-two device files and no
> subdirectories reports nlink 24 instead of 2, and SR-IOV VF enable
> and disable cycles, each creating and removing the VF config space
> entries under /proc/bus/pci/<bus>, inflate the link count of that
> directory without bound.
> 
> [...]

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

[1/1] proc: only bump parent nlink when registering directories
      https://git.kernel.org/vfs/vfs/c/552864f6ac8f
