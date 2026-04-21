Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6C30FC34;
	Tue, 21 Apr 2026 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771543; cv=none; b=mG+Djnpg1C0LOqweUii37fAEeAawVLJqH1fEV+5xR0KSn7u9lTnD9kdaPLJM1zgCPBksPQJhn+akdEr1yfLPEl6REor9FAttR2toAimoUP6pFS0hBHSo06Q++0BtJkoYhSJw45w51k9Utnuvd+PXwuVN4IylbNcesnfax5WM6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771543; c=relaxed/simple;
	bh=hoR7q1rzFrJjiImN6LPDzH4HQGIwfYa3vpYeXLs4FNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VdjdPfVXlSyJgZvk77uE29ta3jBjLoCchwi/B2qVqXhOw949JipiiVNMD/duheJ0r0T6ulpDGJ5J7FCdp7GRp6Myi88lljXl1XietDpejqUEB2t8cErUYXHgrTBNSfxDjPlmAOcnVWwtE0Sk2TDBboyrxV6Eta15Jx0nKwhXnXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUFZaUT4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUFZaUT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F110C2BCB0;
	Tue, 21 Apr 2026 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776771542;
	bh=hoR7q1rzFrJjiImN6LPDzH4HQGIwfYa3vpYeXLs4FNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUFZaUT4XcR7sLlucQoFBgtAjdXNdrD3tPyXRRpNad2CPIBFMawApE3pRi2s5j/YR
	 wjaHs1xSsYzyW90p5LXqmrUcz5zIl4WsAPI/9o6meZ8ymEsagard7DYrDQaIHi3z7j
	 04pdhW8gdR6llZMvhxL6XZ/LVdqQNSOlS+M4jr1dlFxO/8eaVLY+DZM+fvTR7u+AhS
	 Br4aSTLGLOf+h4eGjG7fuXqHXwMSlcTCbyOAxnnp25z/V1eo4oNqhHzAse3Mjdi8Zs
	 fFfpWLD3M9qcet5jiIYXNuDnkVLoIEmJI7TsE9ozElqLqqvpKhV79uxIVL+ONSlJoZ
	 EUJNBAntya2bg==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] nstree: fix func. parameter kernel-doc warnings
Date: Tue, 21 Apr 2026 13:38:58 +0200
Message-ID: <20260421-aushilfen-emsig-a6dc6609a91e@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416215429.948898-1-rdunlap@infradead.org>
References: <20260416215429.948898-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=brauner@kernel.org; h=from:subject:message-id; bh=hoR7q1rzFrJjiImN6LPDzH4HQGIwfYa3vpYeXLs4FNY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ+T7yU9JHt6SPmW8U7/jqyHTCrNpzum9v/hycoQfXur Vv7jx0M7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIRAIjw0bGrP53Ba+n5p24 eElom/EecZss7Yu6m6dZLszcyLrxbz0jw9xlbte+5n+y+//rvnkpw765Zk+uSrS7Sp+pXJd6KLZ nDjcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 16 Apr 2026 14:54:29 -0700, Randy Dunlap wrote:
> Use the correct parameter name ("__ns") for function parameter kernel-doc
> to avoid 3 warnings:
> 
> Warning: include/linux/nstree.h:68 function parameter '__ns' not described in 'ns_tree_add_raw'
> Warning: include/linux/nstree.h:77 function parameter '__ns' not described in 'ns_tree_add'
> Warning: include/linux/nstree.h:88 function parameter '__ns' not described in 'ns_tree_remove'
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

[1/1] nstree: fix func. parameter kernel-doc warnings
      https://git.kernel.org/vfs/vfs/c/957762b9d1e0
