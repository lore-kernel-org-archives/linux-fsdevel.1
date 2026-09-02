Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9247FAE7;
	Wed,  2 Sep 2026 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351244; cv=none; b=VFBIjRPMo6bj+EffZCYb85/Q406Tt5Bcf6+t0Yxr9pNP9+Wh67xt7wvSZX9pCTowogtBvbC3TNiHgn3/kAqbOjnRbdacedHb4gWhRkuZHuM9Gi9Q6LBKlEzL5LkSXNIXW4vAUWVwqj2Q2DB2hZCZnz5BWlxn2sCE2Hpc3lIRm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351244; c=relaxed/simple;
	bh=ZDcOggslxCVkJ8daW/g8vyDbXApQQ0+Iaaqgg/9yIdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+c0WPJsW+BJDrByfzBLTz9zbTYsxDtoBY87GuHAAnml8mcHsSlwpd9o1h8sbAGtcX/qwhC98WFR4ZJmtv19ZaH7P/ZLoLT2QxHvrkRVOsoa5OvV4PbPxGXqn4yMb5jSxM+fGcjqo2RuJXZqQk8j+QWeoW3gmma9if54xRem4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj4L9/Bu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj4L9/Bu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8FF1F000E9;
	Wed,  2 Sep 2026 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788351240;
	bh=ajQ5Fb8+rIem6vBhUF78M4psB5Abho1rTJe15gUk4K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bj4L9/Bu3HfhCcrFa5F6oBAnckAeIIqCUz/xSXVfc9nDR9+ozeUGRIVEVMyTSwOHc
	 sAlyC1UhLF1VigIiWYoOu11tunhyve+q79nUH1nNbVAGMnb6twlAYbY0flY2X5a9pv
	 KSVShCz8XGnKzqBgw7FQGBhNAKonAL18M4rB9JSxhy3DP4GvRFbyHAGIbYUkP4VCmx
	 Qvn3r6c0A8HbBCPmz5ZezISbAU2A8zE0K/62Bt8W/sg0N2y7euxB5lT3rVaZL1HkeF
	 ZBn0orzK6uIsSLzNvuzK5The3evJHhQAsjAEiSAenay1dhrP5Im+Wg95Qg196NGisl
	 6gH0feS1Telig==
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] afs: Miscellaneous fixes
Date: Wed,  2 Sep 2026 14:13:53 +0200
Message-ID: <20260902-hirnbotenstoff-lernen-haselnuss-96e280463c84@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902121024.3328255-1-dhowells@redhat.com>
References: <20260902121024.3328255-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=brauner@kernel.org; h=from:subject:message-id; bh=ZDcOggslxCVkJ8daW/g8vyDbXApQQ0+Iaaqgg/9yIdQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNEGbmWFJodjtvuQ2HTqH06vlT18omSJ+2ZeF5u3XVt R0SM6IaOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiqsXIsPSawr6fvRtLVf44 Ta8v+7L3462FES+uVxrIBXRYVdxk+8TwV4TDUX9fwH25sLoV8842XcnVa1R52potdsG/8lRERos 4KwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 13:10:18 +0100, David Howells wrote:
> Can you pick up these miscellaneous AFS fixes, please?  Three were found by
> Sashiko[1][2] and one was a posted patch.
> 
>  (1) Fix missing kunmap in afs_dir_search_bucket().
> 
>  (2) Fix double-unmap of directory block.
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

[1/4] afs: Fix missing kunmap in afs_dir_search_bucket()
      https://git.kernel.org/vfs/vfs/c/950ae84b5cc9
[2/4] afs: Fix double-unmap of directory block
      https://git.kernel.org/vfs/vfs/c/e3cfd3eb7d5b
[3/4] afs: Fix incorrect free in candidate cleanup in afs_lookup_server()
      https://git.kernel.org/vfs/vfs/c/044d596094af
[4/4] afs: Clear stale peer app data after address list changes
      https://git.kernel.org/vfs/vfs/c/ba0623fc19a4
