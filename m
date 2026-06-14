Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A472279DC8
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781462174; cv=none; b=qVXhVr3sIWLOfHUQFgTGZ+NCyqruM8LQV5Atppv4ne3Zj9as9o4sDEOJ2qy8q9LXd9pjCsvwesUeZxEaXcxfmHAVs1n/HbUwLtDvXS8nHUNN/0Vg0RpBqQNV+wcZ+CSHRRD3B9KnlmCANgSNvLCwc81PkXXmBF5tpe6zGNFbfxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781462174; c=relaxed/simple;
	bh=srTtO34fC5A3pMRmQOx2tJeiMXRixXz7iyia07n4WSc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uxSAXa2kdqoxeMvVb0+zdbaJoVg3n2lIUR3M3IbWRJEGYBvccf7ha2q39WSyk7zWEEPp4YGuTKn2wCz9U0vW5pBwQq6iU0C15iE9b7GCy5Qf+K4ptkVqxNs5Siv7TYXl3Kq4P89mQZFwwRZ5kWypqhyVKGq0K9sa2loLF3X+rg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=NF1v9QDk; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="NF1v9QDk"
X-KPN-MessageId: e9e9c360-681f-11f1-8ff8-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e9e9c360-681f-11f1-8ff8-005056999439;
	Sun, 14 Jun 2026 20:36:10 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id e9e852d5-681f-11f1-8109-00505699693e;
	Sun, 14 Jun 2026 20:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=o1vTMXG5RNs6RhVkl6v7EmwKLLZaB+V89dadl/1ILVA=;
	b=NF1v9QDkGCrG+GxzRkh61EcCv7RxGYQDsSixsqSPwwwCqZRovvSoThIX0Zyc0zzInawdW4u8U7dFy
	 J0G6F3WTchCq/6b8EG9rEKQpP43LUlJAALh+7KUJiq5A7rIRgnFUZT2LzC/3q5hpMgzReX09+aZFTU
	 KydetOgfvn5/Bj7fgIoFap77Dch5v+pW0MOHYn1HPXKUwNo8Oyx5AajpHigix34edjc63al7m3xV83
	 S+tpSdr6uZ3lLniemKnOjnS/rGT9Eltd6LhU6YME/SNwmmKHi5Hl9S1kohJXSoL9QLLOmjKrVWuQ6A
	 5/lIkx8H5HW3ikES5RRC9ATq+xdDUdg==
X-KPN-MID: 33|R7q/6mfgf/8+piFDJsvAgXT9sVq9HhP5ahO0R8O4J+nCzg+0415gPhTGmECj4XR
 +8T1ij15IyJliW1GBH+TBr+GVVbExS3A3kENcYXwaXhQ=
X-CMASSUN: 33|dsOgFxkhfqSVawsVadOa1jChXW6wDUEvSSV02EsdJQce61zuzMh93mOaqxvPOHU
 zN5TOMn4+jEECEJVOnb3t+w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id e9da505c-681f-11f1-94b1-00505699eff2;
	Sun, 14 Jun 2026 20:36:10 +0200 (CEST)
Date: Sun, 14 Jun 2026 20:36:10 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	NeilBrown <neil@brown.name>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Charles Mirabile <cmirabil@redhat.com>, audit@vger.kernel.org
Message-ID: <83236167.1691696.1781462170184@kpc.webmail.kpnmail.nl>
In-Reply-To: <CAHC9VhSN1j36Mo0tCOD2EQi0w5dXg_2sOcBw9vEqb1wRdsPh5g@mail.gmail.com>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
 <20260531182045.171711-6-jkoolstra@xs4all.nl>
 <178028260358.2923901.6788358930458921830@noble.neil.brown.name>
 <CAHC9VhSN1j36Mo0tCOD2EQi0w5dXg_2sOcBw9vEqb1wRdsPh5g@mail.gmail.com>
Subject: Re: [RFC PATCH v6 5/9] vfs: lookup_open(): move audit_inode_child()
 and i_op->create check to before try_break_deleg()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal

Hi Paul,

> Op 01-06-2026 18:27 CEST schreef Paul Moore <paul@paul-moore.com>:
>=20
> =20
> On Sun, May 31, 2026 at 10:56=E2=80=AFPM NeilBrown <neilb@ownmail.net> wr=
ote:
> >
> > I don't think this is sufficient.
> > I think (and we should confirm we people who know about auditing) that
> > the audit call should come before the permission check so that there is
> > an audit record on failed attempts.  In that case the
> > audit_inode_child() all needs to be much earlier.
>=20
> As you likely already know, audit_inode_child() exists simply to
> record information about the file/inode access, the audit record is
> generated later (and can is dependent on other things/config).  For
> that reason, yes, it's generally a good idea to call
> audit_inode_child() as soon as we have the file/inode information.
> Auditors want to know what the user/system attempted to do, even if
> the operation failed; in some cases the log of the failed operations
> are more useful than the successful ones.
>=20

But currently for mkdir(2), mknod(2), open(2) with O_CREAT, we are calling
audit_inode_child() twice. Once before actual creation (mostly in
may_create_dentry()), and once afterwards in fsnotify_*(). Is that the
desired behavior?

>=20
> --=20
> paul-moore.com

Best,
Jori.
