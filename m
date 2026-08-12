Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE244305698;
	Wed, 12 Aug 2026 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519502; cv=none; b=U0pa3BI/9NSK/TbZW+UOE53WoPMeVIy+yVtn9setu5KQQdSZiUkSxDJKuroXFIRKJbA3nIVYkHQsXNos29jZmppxTRJVKn0bq/h+ARUX14PzOA3ZI9ROEsihBvQANEc1pPxgSC8aXSomH/Q6XppdV/iOvdc945vQs9IcmfLuQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519502; c=relaxed/simple;
	bh=RVisNW934lVNq7xg6gaxyC8l+dunZK/8YctltZg6XWw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DtIGzyhbYW39zvPxeXfrd7XlPDQl98JcMwYuTe/HBWwZYc8a55d/icXDtIDxxpA36Kck7xB47nXNFRWKrJr1lXwhQpqKhHYqBudr3TW38ZrkACdc9dNBsKlDitOVJu2d0fbOSmHkQ39XY3k1WmoCDhCUdxWo1oKtaXCYrOlYsfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeGd2uFf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeGd2uFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C3E1F000E9;
	Wed, 12 Aug 2026 07:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786519501;
	bh=71/jDWiLOfAZVNdEsbeOb07cDuraebHmi9FiGZeTn6A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PeGd2uFfQ9VhgX3o85O/djH7vQt8+pm28ZjEwCb3i4SWWayus2G8Q0itLAk6HKDNY
	 VD/3MiyCBMrW91RNjAMRJdO8jHKWtf2JzgZRD3p5uuzvDRLC7DBtJlrKbHf6aHZLAw
	 8lMmZch0qJv8Wwjpzp/gl3+K4To1cr2Ms/Q/yFScCTcLAtiMHkRE9BxwaDMbuTsplW
	 9pKez31E/FMpojBB50ZYP5kvW1G8kfax46aJ4tq46Z8Wf38yCTNZJoVeRuKIX921EH
	 gXrAlEhvJ85SqyMszyxQx4FdTQKwgaGQ8Q4ltHrk79G2FO9tZW1rpSvjB/mc6t8QOq
	 TmAG7Q/fFPmKw==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, Manush Prajwal <manushprajwal555@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260808182816.2399-1-manushprajwal555@gmail.com>
References: <20260808182816.2399-1-manushprajwal555@gmail.com>
Subject: Re: [PATCH] fs: fix switch/case indentation in sysfs() syscall
Message-Id: <20260812-spielplatz-hexen-leihen-b1424bc57515@brauner>
Date: Wed, 12 Aug 2026 09:24:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=887; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RVisNW934lVNq7xg6gaxyC8l+dunZK/8YctltZg6XWw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVyJ+2mmV3qPR0uW3z/EaTvpS9N+bp+F8PnProw/GSD
 UvmCUm0dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE4grDP+VYM9Oa5sffnv/S
 WbPooY8n+8mtd29NOfJ+/rntG5q2ta5gZFjc6P73YMDiHIMle3VO9p04aHt1Pn+RTzhnU/ldt0W
 F5cwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sat, 08 Aug 2026 23:58:16 +0530, Manush Prajwal wrote:
> fs: fix switch/case indentation in sysfs() syscall

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] fs: fix switch/case indentation in sysfs() syscall
      https://git.kernel.org/vfs/vfs/c/c5e7f72a9c91

