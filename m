Received: from calculus.sigma-star.at (calculus.sigma-star.at [188.245.196.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE249620;
	Sat, 19 Sep 2026 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.196.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828121; cv=none; b=FMviri4/kBwKT8YcxDETxR6eNH2US7nRCjeiGt9491kzBQM73earnQyeTIfdCVGP+LarrukON4Vn7UqWZf1oLqMA3WyRMF4wQbMq0zSfjwp8knN953Cu/Yu56aSBQIJyXzjHILmXizB7RmR3/q3S6BaDiO/pJAARMPXId/2hyFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828121; c=relaxed/simple;
	bh=wHFhJZYMC+Cf2lvydqNtVJcP//AgIIi2qiL0aSglkVY=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=BvzpRoY1rrtkqCJ9qSPL/DasEZMLhro4nG+QAiq2HicNAgwoYAXBu5gQR1v4jpmQWywT+dJ8HzQITskgWQxZOPus7LtZ8CIKH/fYUuKhemNWRuaY8WshAxH/4u1fYBAdSFCsckwQ76JzYfb6sA/ho7K2OR9ryGLHPGxDQO9lStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; dkim=permerror (0-bit key) header.d=nod.at header.i=@nod.at header.b=7vQXNP/H; dkim=pass (2048-bit key) header.d=nod.at header.i=@nod.at header.b=imjidSQu; arc=none smtp.client-ip=188.245.196.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nod.at header.i=@nod.at header.b="7vQXNP/H";
	dkim=pass (2048-bit key) header.d=nod.at header.i=@nod.at header.b="imjidSQu"
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260901; d=nod.at; c=relaxed/relaxed; r=y;
	h=Date:Message-ID:Subject:To:From; t=1789828095; bh=UrgYY8MFqXrOzsNouXVaAax
	Dtnqt6fnSXyeh0VeYM04=; b=7vQXNP/H9pGK1c3sSY/0ts6j4BwJQQ+XL68EgHg0L7wuJxqWT6
	YAC3PsBSpDVmJlU6ziWQWoDgdNVwsKAmfRBw==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260901; d=nod.at; c=relaxed/relaxed; r=y;
	h=Date:Message-ID:Subject:To:From; t=1789828095; bh=UrgYY8MFqXrOzsNouXVaAax
	Dtnqt6fnSXyeh0VeYM04=; b=imjidSQuACRRCll4S1R1l/07/MzzkUkwiwx9HR69cq66NxOBpD
	MYQVNIUs5gHDC6oq1sWv/ppmhxZz54Qypde1greKAAMu3K7zYJAIOTwappCLfYMmIt2Ov2xO4l4
	VJaY9LfbFeufDEEAZfGS31axjn/dvpsjyHGfRAiYK566XPjwiGZF3k2Y0ysMAYXzWCMdoV6mahy
	AECeNmF0RioV5w9R414+0UrRgeXEJOHeMriq9H/ssHF3oGrthNgytBrPZ5nzazMmGmFDmnZqWsD
	O1ciQJdv32pnd9FnEJ2K8ArPz6dlH5wpVcdRaqEhgLHi/GKcNSUArYMb6Gb51ah7LJQ==;
From: "Richard Weinberger" <richard@nod.at>
To: =?utf-8?Q?J=C3=B6rn_Engel?= <joern@barelysecure.org>
Cc: "Chris Roy" <iam@thechris.in>, 
	"Greg KH" <gregkh@linuxfoundation.org>, 
	"syzbot" <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>, 
	<dakr@kernel.org>, <driver-core@lists.linux.dev>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<rafael@kernel.org>, <syzkaller-bugs@googlegroups.com>, 
	<linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>, 
	<vigneshr@ti.com>, "Adarsh Das" <adarshdas950@gmail.com>
Subject: AW: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
Message-ID: <mu8hfoxj.7ce5e90c-076c-4b73-813b-f9c60310ddab@nod.at>
In-Reply-To: <aq6afmdN5DYpuUa2@cashel.logfs.org>
References: <CAE2Bdm3NuEHshrG6K2boKAnCQUvT5SX79cP9nPgS2s1afzY1hg@mail.gmail.com>
	<6aab0f82.e91c2013.3bdb06.0009.GAE@google.com>
	<CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
	<2026091753-broadness-bootie-b683@gregkh>
	<CAE2Bdm14hif17B8RTAE+PhWEps5Fzh=WPurZeSNp9C6TqCKumg@mail.gmail.com>
	<aqwuWWMwdIcx3704@cashel.logfs.org>
	<mu82xsi6.76ee613a-07fb-48b1-9336-99e8780e8b6e@nod.at>
	<aq6afmdN5DYpuUa2@cashel.logfs.org>
Date: Sat, 19 Sep 2026 14:28:15 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am Sat, Sep 19, 2026, 16:22 schrieb J=C3=B6rn Engel <joern@barelysecure.org>=
:
> I added Adarsh Das, who also attempted to fix this bug.
>=20
> On Sat, Sep 19, 2026 at 07:42:25AM +0000, Richard Weinberger wrote:
> >=20
> > While we're here, maybe it's time to add a decent configfs interface to
> > this driver instead of configuring through module parameters.
> > That way also multiple instances are possible.
>=20
> I honestly wonder whether this driver has any production users.  It is
> somewhat useful for developers that want to simulate hardware they don't
> have.  But beyond that?

IMHO testing is the only use case. I use it regularly.

Thanks,
//richard
