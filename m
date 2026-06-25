Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D1A2135B8;
	Thu, 25 Jun 2026 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383243; cv=none; b=akPG6Dwo4/K0laBCvIe1jtXil+5gTE8WuXo5lPeuQU0Y2MBaocJ/BfUxRV4722Fht3aNMCruAOoUo10VbBvXbqnFXSY8fnYKPlgSgrqJ/hvafNfWRgKc+N8qgUscdCNLevqVC2M/B/WmK7ec5IwsJpcbWklRiQt4TgYm3tRCDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383243; c=relaxed/simple;
	bh=2VCEOH6iY81GPX8FSncQ8y7SrV+iXm4kICvQUMqnnOk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ba8JrZg5KJ4Qg1Fk5SHoS0fnBvhHDdyCO/nt58TdPyRtIhqyRN58+HQA7L/832482aJaAa+SQCWX97v32LjwyonnUhy/Z1FoeBwqQ56FuwpolcY0qppw/DhuGOXVwpBOugmvBEa6qxzynQtMF57ZJUZ0wFJDeo6nt3pAr1hwWC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1hf2puJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1hf2puJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B641F000E9;
	Thu, 25 Jun 2026 10:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782383242;
	bh=VnSQ1dgW5Ou8V5en4dctWAxSYqdJB9ThwBmw1FHtFR0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=J1hf2puJOp1XKYhxby2JzJwKIZgJaMgzj5fX2gJn24EPhPp+7jJaBvyZb2XfOVMah
	 VhRHLNTtGQd5wCRg0FrXtZHSPZPXKgbXUi+EtqgyRjX2dmplyM/YH/uWBlF8LDfDzw
	 6mYRSDFVgk22jyplgdTRty/6hrqKYq0pldFufCQUxCkE+I7giyidli9EkW0OBNjfAo
	 xgw5rt5DEkKwjYfHmhYgmPIeJ78GN2Fv8enPGhvOjMunwU5BU7qDmMv5688Io+hUo3
	 2h3gaBUVjgy+O9EOX0Ys6H6bOy0YOrjC2XcPwYdTpwsg8O/zOAeMVwTXgQJcuI27au
	 Vow3zTC7fT69w==
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <kees@kernel.org>, Alan Urmancheev <alan.urman@gmail.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, trivial@kernel.org
In-Reply-To: <20260623052322.74711-1-alan.urman@gmail.com>
References: <20260623052322.74711-1-alan.urman@gmail.com>
Subject: Re: [PATCH] exec: fix off-by-one in binfmt max rewrite depth
 comment
Message-Id: <20260625-speichel-oktober-schellen-56132930eeeb@brauner>
Date: Thu, 25 Jun 2026 12:27:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-d9d01
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2VCEOH6iY81GPX8FSncQ8y7SrV+iXm4kICvQUMqnnOk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTZMnX8Pp6zXHmurVtvR8RF1toPBSoy2ofPer1luvbjx
 P4/jvP1OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS2c7wz+Ldxh9/V569cnvF
 fatlp0zrD8xQm9j8Pn4Fz9JHZyTMGGsZGS7ahv17cbvl5boAu+QDEll8WnsyWZlXdnuyHtb7MGu
 vIBsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 23 Jun 2026 01:23:22 -0400, Alan Urmancheev wrote:
> exec: fix off-by-one in binfmt max rewrite depth comment

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

[1/1] exec: fix off-by-one in binfmt max rewrite depth comment
      https://git.kernel.org/vfs/vfs/c/3146aada8527

