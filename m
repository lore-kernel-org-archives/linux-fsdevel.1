Received: from calculus.sigma-star.at (calculus.sigma-star.at [188.245.196.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2993B8D48;
	Sat, 19 Sep 2026 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.196.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789803798; cv=none; b=iIxrcMaJ7DE/lQuqRS6HbOexNJjplE3S8pFfQtc1ZBo1DOo0uapXIYfuNN0aTgCAzxxwCD3pyqSDzeieeGxhiIvPJYBlpMOE0av8tWKKYa03jSWfihbjsVX1KHL5Op+32HZSFhxFyTAaaAjlCKYGA6UvjftCg1pEj+EGj2Xef2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789803798; c=relaxed/simple;
	bh=+be4Xw1gxU0oyoWeB/FkizQKsrB7PwjheqScq1kRY30=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=tagXZgqnr29zKp42Wq0QSG+1cKoRjEm/RbdtzehdijraQmKNcaKtGyDULgoxqO42I6MGicuV9UkBbObMh6gvqYTzF73uLbccDUcKAWLbz2rj45ZLk1tnI6DDbSTNeChsHkWepc+KjOpV1gryQ2FJ3jJ7+kMoCZfVJaCud/d7nok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; dkim=permerror (0-bit key) header.d=nod.at header.i=@nod.at header.b=6fFKz/kN; dkim=pass (2048-bit key) header.d=nod.at header.i=@nod.at header.b=rAmDeOW4; arc=none smtp.client-ip=188.245.196.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nod.at header.i=@nod.at header.b="6fFKz/kN";
	dkim=pass (2048-bit key) header.d=nod.at header.i=@nod.at header.b="rAmDeOW4"
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260901; d=nod.at; c=relaxed/relaxed; r=y;
	h=Date:Message-ID:Subject:To:From; t=1789803745; bh=YP8vnLhklWgFXgieU8N+ZD3
	bF6ZH1bbcm6B02tsqZaA=; b=6fFKz/kNl8A+tDwZQVk2PZ5Lrl5fFoEF1iEY1/FtdDhse5L9vG
	9V6J4mIudcW1v76utgCZF050QvMqKBZ3mqBA==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260901; d=nod.at; c=relaxed/relaxed; r=y;
	h=Date:Message-ID:Subject:To:From; t=1789803745; bh=YP8vnLhklWgFXgieU8N+ZD3
	bF6ZH1bbcm6B02tsqZaA=; b=rAmDeOW4469rHGd9hRodDaCFJCurw8tO9o7On31U4bR0wC8u9/
	irYiuyUvizb/WJHP4xTA1T0WOxPRX8pDvSjRx8v4IXmP2nQzIZd8/hYq1fw113aCqGv35hUTSG3
	Q4f/U/cIahmSdM6g+xA0vQyQwPMl1e4PQGpCYGTQ/LD5VhIObKWWAKqzf2/Ldn1MY9B9lkZQI57
	eSpGo0siNIUXWRYSmGIFWvo6X4Q7I9JhiSBbdvVLu8wASDODiR2DcGlA7WLWPyLainvv3ed8B08
	7VwbSA9VjqL++MKWzBYUsLWQpyQfUXlb31Fp6dm0w1OriQks/H43/8UDVPklY9NfeuA==;
From: "Richard Weinberger" <richard@nod.at>
To: =?utf-8?Q?J=C3=B6rn_Engel?= <joern@barelysecure.org>, 
	"Chris Roy" <iam@thechris.in>
Cc: "Greg KH" <gregkh@linuxfoundation.org>, 
	"syzbot" <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>, 
	<dakr@kernel.org>, <driver-core@lists.linux.dev>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<rafael@kernel.org>, <syzkaller-bugs@googlegroups.com>, 
	<linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>, 
	<vigneshr@ti.com>, <joern@lazybastard.org>
Subject: AW: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
Message-ID: <mu82xsi6.76ee613a-07fb-48b1-9336-99e8780e8b6e@nod.at>
In-Reply-To: <aqwuWWMwdIcx3704@cashel.logfs.org>
References: <CAE2Bdm3NuEHshrG6K2boKAnCQUvT5SX79cP9nPgS2s1afzY1hg@mail.gmail.com>
	<6aab0f82.e91c2013.3bdb06.0009.GAE@google.com>
	<CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
	<2026091753-broadness-bootie-b683@gregkh>
	<CAE2Bdm14hif17B8RTAE+PhWEps5Fzh=WPurZeSNp9C6TqCKumg@mail.gmail.com>
	<aqwuWWMwdIcx3704@cashel.logfs.org>
Date: Sat, 19 Sep 2026 07:42:25 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am Thu, Sep 17, 2026, 20:16 schrieb J=C3=B6rn Engel <joern@barelysecure.org>=
:
> On Thu, Sep 17, 2026 at 01:28:22PM +0530, Chris Roy wrote:
> >
> >  drivers/mtd/devices/block2mtd.c | 118 ++++++++++++++++++++-----
> >  1 file changed, 98 insertions(+), 20 deletions(-)
> [...]
> >  /* Static info about the MTD, used in cleanup_module */
> >  static LIST_HEAD(blkmtd_device_list);
> > +/* Protects blkmtd_device_list and early-boot paramline updates */
> > +static DEFINE_MUTEX(block2mtd_mutex);
> > +static struct workqueue_struct *block2mtd_wq;
>=20
> This is just awful taste.  You are inside a file called "block2mtd".
> The prefix to the mutex an workqueue add absolutely nothing.  Calling
> them just plain "mutex" and "wq" would have been a better choice.
>=20
> Good names should tell the human reader something.  What is the mutex
> protecting?  What is the purpose of the workqueue?  Pick a name that
> gives us some information like that, please!
>=20
>=20
> You seem to have used AI to write this code, so the bad name choice was
> presumably also done by AI.  But you are still associating your own good
> name with the code.  You should try not to harm your good name by
> letting things like this slide through unchallenged.

While we're here, maybe it's time to add a decent configfs interface to
this driver instead of configuring through module parameters.
That way also multiple instances are possible.

Thanks,
//richard
