Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9C35F192
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 05:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783918914; cv=none; b=pHnlppEdwzlZ92R+Jlwv51VmltCcT+CFQ0WM5jqAOtbN1JkXL5abFRzgVB5mwedP/l4JsfaOptdVYoso05pNbrczsclE5MaQDUcw0O981XpMePBNF3zHeIWWdQz5lUKcXIWDbEzCc/jYjlvBE5g6Mbbw11a19bZJPbaTAQfgveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783918914; c=relaxed/simple;
	bh=4wwvsiql28DVFDZD6Qpe9H5jOuycVAFEq/lG+6wmXu8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=sXFW02ev62NQhnxX7W70aMISJfRKTawPbqfrUrFo4cPvtgo3UR6p3kU+nD5EK+NkNFvZtXXBrdEavI2TnrGhQRPYhokJk600xloxsdCopEIN+gr/7wPZnCoJ7TaBIiWI8vQdZFFc2/OhSMZGc6U61tqo45U0A4JSPKKSTuz0GfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IIROkMuG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hV0Mi18g; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IIROkMuG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hV0Mi18g"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 401EA1400073;
	Mon, 13 Jul 2026 01:01:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 01:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783918912; x=1784005312; bh=OW+Ah8EL6ef3iqinTm/szCCADu2MMHyIULc
	YARIc8WA=; b=IIROkMuGZrZu9ir+shoHfWTU4LPYhBG77c6Kf0pMq1H+LCBWxYh
	FXLG+N3BbCHqborXBd/0TFL2BJsqlHzsklJVUxLZ/9jrR4p7mbpuMo3+bM+HByDb
	+6C2syi1efKVxXIEQShADpDRPsj+vl38dlzjUEEr5/8Rh4n8u58LZ2IL4Ftuu4eH
	jzL1EvFoDgFnARqNMwE3eLJNSa/UILL8LPsQ7hYqAeGSA4FCbQqueozyH9WtwdRI
	xjpWmrx6Y3zwPMkj+zUYV0MB8bz5UyD4Hyoy6Ys7ZIa+gBTbDZuNcY7dzR+TOocF
	uefrTQPiwqZNLBnk7AC8tETaLiKsaGNT8Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783918912; x=
	1784005312; bh=OW+Ah8EL6ef3iqinTm/szCCADu2MMHyIULcYARIc8WA=; b=h
	V0Mi18gNSOfQcw+5Sx5VvaRG5AE+vpoZlE9dxsCGRC5g1XU+miIX61abLfJ1WOrT
	ljQvnh9ms0+S6wdID1pgEH7L5AFO3mxl6xXtOwVQ6CI1eI4Og+BajKFeoSt5CVya
	npwBtCASe1wQiYpyeVtzcblMX/jZJypqO0tni8/aG4cj2io8Ypmmgtf1jPcrJWoj
	6vUidkd/1JGPnIdhfJSxj/+8ODeF1TwMkq7aiyOpZMYtP9Xq4/4jD67BfUZ+GdyM
	/M8YqklHAdIY+RG8wRN38hdPSh9UTUXUH0vt2/AKzzPpO2T/5wJQWamQuNrmZA1U
	mwUFA7mTDI/bqSnSgE0Mw==
X-ME-Sender: <xms:P3FUagvEI-hcptoxnicQATEWUb1OA5FSeYyBtvgGYnxKrScBu-58Jw>
    <xme:P3FUao6oFoymBtvBrS9Bh62O7lj7zLmgZ-HbEO4v5LoiNbi2nyKVxJuCOJvtF0L72
    wvKiQBtj4ZL5Irx8I0Ik0Msi2vfANexSFlIl2ak8PoW_2qTrQ>
X-ME-Received: <xmr:P3FUavRr6A92nCOWP0jagjdDe3FcgaKqtBQ38Cq7DH8QsVz6e773kXA5_G0Nt_AoYq9VLKtRtsKUfOsNZa3pxcI-Qq7l-xo>
X-ME-Proxy-Cause: dmFkZTFy2NbZwrN/PykEZCKjvk6Gr4tcJEFyQv2Xr//PfGdg2pPNOihc0TURLHB+RNf8V8
    jZZf2P2WILppEAijdJ/R6iwHmd7+Qtnihc7gHpxsJA8gcWkVfHOfOeFMt0rEFXA9VoD1QO
    jWAYFaBkHXtMZAw7+IW/hPn6n4mSf5BujeMeHUX1plfJebj5hh9K/NQcztoEnoTdkbNjaj
    Ia96jeKxFZbThE9jR3p9b4duU3VAahjwW2Vk1Bubbz+vUMtPQ/VPlYfJwQOt7rti6AlTRA
    VrcSl2JIX6HjbCo7VqAsCg2k0C/ANJiO+nBjx4Kwf4vva7d6oSHlSfT0SBn9cpLLcuplJL
    9xWavbqOsWY3XawFRcpmiZEzIcQ8O4765tzKG0ojB3h7mxMRBZE9UVG3WRqKTbtaIRPSGZ
    UyWlOtXOoYHxVv38ozOI7UcQ16Yj2peMRKMiuaqcQYDtXiW3JYLsPp5l10tYGMGPhP7mNZ
    ChnORFhnm5SrURvEyJ0g7/Up5ppwtKgs4NWKA7H/G+YMBKKWcVrKQM8xJXlfFOPFjCWOqW
    BOOzaUoIsjl4Qwwc4m4otduowF7frFVduIyn4Ke4b13A0eAZjzMLMMAPgH/dsrkKKdKAaG
    Mn9f8EWwZm+T5Zqw6QAGToF9QV106xYcf3wTZnu2LNzQWt/vx8KCTdSnnXAg
X-ME-Proxy: <xmx:QHFUanoVEM98mjUOCKwNkTQ2-SO6msqZipUmGF8wfVv_K_n6g4FQ5Q>
    <xmx:QHFUatJTr9hCPvUMOxU_09N-y3YvfAHftVEfAyzsCtxCZ_kyyelpqw>
    <xmx:QHFUaqqGLq-roSKsO8IX_HJK3L_F-eniZYYeoom--BXArA6IbDy2JQ>
    <xmx:QHFUalzPmSml7rqUcRBef2ONEQ9jLeYyJ55Teo5xVr2UPdUj9-Fmkg>
    <xmx:QHFUalc6ssv4_W8wSTP2xDj466TectgX9ASvGJ_vx9UI_-PzeaOFMyFQ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:01:50 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: VFS: prepare for changes to directory locking
In-reply-to: <20260701233128.3356519-1-neilb@ownmail.net>
References: <20260701233128.3356519-1-neilb@ownmail.net>
Date: Mon, 13 Jul 2026 15:01:48 +1000
Message-id: <178391890817.3371781.14778108771142054222@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


Hi,
 any idea when I might get some feedback on these?

Thanks,
NeilBrown


On Thu, 02 Jul 2026, NeilBrown wrote:
> These patches are part of some prep work to allow changes to directory
> locking.
> The short term goal is to invert the locking order between d_alloc_parallel=
()=20
> and inode_lock() so that d_alloc_parallel() can (only) be called without
> holding inode_lock().  This particularly requires filesystems not to use=20
> d_drop() in the middle of an operation, which particularly requires the d_s=
plice_alias()
> change.
>=20
> As it will require d_alloc_parallel() to NOT be called under the inode
> lock, d_alloc_trylock() is added which CAN be used when failure is safe
> (dcache priming in readdir).
>=20
> I have other related patches which make changes to lookup_open() and
> related code but I think it best to wait for the O_CREAT|O_DIRECTORY
> patches to land first (unless it is decided that they won't land).
>=20
> If these patches can land in a stable branch, I can start making changes
> to various filesystems which depend on these.
>=20
> Thanks,
> NeilBrown
>=20
>  [PATCH 1/4] VFS: fix various typos in documentation for
>  [PATCH 2/4] VFS: enhance d_splice_alias() to handle in-lookup
>  [PATCH 3/4] VFS: introduce d_alloc_trylock()
>  [PATCH 4/4] VFS: add d_duplicate()
>=20
>=20

