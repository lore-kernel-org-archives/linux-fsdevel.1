Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D179B372EC5;
	Fri, 19 Jun 2026 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781873655; cv=none; b=V/1OZXMOG+onipYMx2GEtlAXTB98dsba1wpjhtipEqadHUrfMMYgQjTCPXo6AKhXEdLFwaldctJ+4axSsMk0xnu/lTXPBzT/vT3gIAmxXX0WCBizXpX8y+gXFjd1VyPmSvUrDl3j9tWSw34KsIZ9sSzusEGxfDItDeXF9bV7asE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781873655; c=relaxed/simple;
	bh=6JhNIEZzTHh40bheDe+TgBeMeGfZQt50qY7sOk2N2Ec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RGy1zXYDyJvvYJNy3G07vvS444WTMSSjmsOWot7OrSWMUJGY0XLfe+ixDxIk0j1RQsPe98FCu9sr7XBuuvuQdinWu80u+8Dpel9BkDRpNCVld8ybJ9M1rn54r9o2TL1iKjiMie1IzRMGXtlX0tGxVLUAwzxjjt1YoCMELHxS3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMraqG0g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMraqG0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586881F000E9;
	Fri, 19 Jun 2026 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781873654;
	bh=iigVIumOE/+LyOQvQLQ3U3eWiMZFZzqgLlVc0QECKmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GMraqG0gPFMy4Lq9NPy2DncZOdc1pwEGXm7PIaamGTMIAErOf6tvwLbeBrSZx8JCP
	 IBtJRV6q95PNqHQMRihX3Sx1SY17M+L5drOi0bwGPKrxzThLv56Pnw5Bu975+Mv5RR
	 xvAotaTvchmy4Jf8G7HvwmVrdFw7spEMBRAyfwOOaOwxZeEanRjfb/MEkkZKYCqtsd
	 RoJWHJUWQnXKTaUPoOrDT3iLhIbLkhqdSzJ/ycodmZa4eacKKk/nnmDY85FqcYQaOU
	 Exg8TtTjbisxzcmyck17Yoico8aFJiwvEfkBy2eVHJ2pLTZ48qwoDcn9lJWbZxDmDF
	 Gi+/RI6jA4yyQ==
From: Christian Brauner <brauner@kernel.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Matteo Croce <technoboy85@gmail.com>
Cc: Timothy Redaelli <tredaelli@redhat.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matteo Croce <teknoraver@meta.com>
In-Reply-To: <20260616163346.32603-1-technoboy85@gmail.com>
References: <20260616163346.32603-1-technoboy85@gmail.com>
Subject: Re: [PATCH v4] fat: stop reading directory entries past the
 end-of-directory marker
Message-Id: <178187364779.344699.3474880356215898745.b4-ty@b4>
Date: Fri, 19 Jun 2026 14:54:07 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-aeb64
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6JhNIEZzTHh40bheDe+TgBeMeGfZQt50qY7sOk2N2Ec=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSZWn+9IJ13eG8Hs1GRdpKSSE3LyvexB0NV+JyMdpen8
 V156i/UUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEZcxn+Cpw+6Kz5Rbdzjvua
 H7GHch1NtjG/Udv+nvvavLuzL4RURjL897lRq2Iy68V9ja2/3vQ6WJi5njiYdrWii8u9IOlEmTA
 3NwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 16 Jun 2026 18:33:46 +0200, Matteo Croce wrote:
> fat: stop reading directory entries past the end-of-directory marker

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

[1/1] fat: stop reading directory entries past the end-of-directory marker
      https://git.kernel.org/vfs/vfs/c/3beb1d0da420

