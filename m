Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D103822AB;
	Tue, 30 Jun 2026 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816543; cv=none; b=iUuXArbDjs5D3NXbUfqgeuQGB9PULk6hdnhxjjZKW3Gewe/dXGdU7igk4KnVcgJ/Pxg9UqXPRi47xA4+QHIHcioLex/iHs3jzmiCGtmX65hDA8wEVyN58wniyFQYFrEDh05gvOISu19M6txM/DEvzOPZsi7G0BHDN1m226tTucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816543; c=relaxed/simple;
	bh=Uq0AmiPRULG4SuuwiKeJgin7vaUsB7GrNjBaenJpRsw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h5DfpYWLndncrrkUree9AEQqcYjFTRDvAkXVgDPSFRkJTWcZnPlcSp0GFRG27jFzmPtKtReBKkns79zbAwRNKnBBcyQjZS4o0MRftLZANfQ6pGHrSdmyOKiM2x5gzQlzNWUMtD1z+TH9E9s87X+ciJ9v3IGQY5bKojp2hSBU7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDzT9prp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDzT9prp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066251F000E9;
	Tue, 30 Jun 2026 10:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816537;
	bh=GuclbIqcdYEh3v8tKBe8oTNDMj/ko73ZEXAHmvPWIaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YDzT9prpUocvmFDM6T8GPGc4zSCTABsVw80gP5zC5ec9iein+fT0UyMKPfUoQM5hK
	 JmHxwJETjDYPj7oOqvK5ZjXBHw3rrN8zgCTgYfCwI94iwB9Ews2xRhk1cuC2db46tt
	 SM0Zwyg78isZUIMtlDK3bR8oZ4YHzYpDf6QI15VWSCqXJnx31J9/VDQoKFYcHlhvvb
	 tY+2T+8rT0hCGazti7Ib0KoJnidZEPK48zmjqsW1rN1y3uj/7AP3GjEyCVT2DVmKfm
	 PImJcwWsVWDbuT4Y9wC8qZindZ+b/JWuSCKK84fWpVcyPfVdBx2HuEsWe0f3EWhAqo
	 NlqCkgbJjCsdw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260629154554.29093-1-luis@igalia.com>
References: <20260629154554.29093-1-luis@igalia.com>
Subject: Re: [PATCH] posix_acl: remove useless code
Message-Id: <20260630-behagen-glasbruch-ausschalten-09cac73854bb@brauner>
Date: Tue, 30 Jun 2026 12:48:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=847; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Uq0AmiPRULG4SuuwiKeJgin7vaUsB7GrNjBaenJpRsw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5zxevz/qxlnlzzCGff+EnJdeuaNarN5OVKm1lUG2o3
 rt93cwlHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5qcLwh/N23227D5Gxiif0
 fJwKN0ufc+AvubX46twnVQLX17ROO8rwPzfQ8PwD4ZqDfOxPfZ/PO7TyXlPU2s5lCz5GxK687Hx
 Pjg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 29 Jun 2026 16:45:54 +0100, Luis Henriques wrote:
> posix_acl: remove useless code

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

[1/1] posix_acl: remove useless code
      https://git.kernel.org/vfs/vfs/c/af695109e830

