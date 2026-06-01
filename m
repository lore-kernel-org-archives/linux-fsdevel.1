Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8ED392C24;
	Mon,  1 Jun 2026 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357409; cv=none; b=pTY3yEtWFLjoduPW+hLjaB0v/EXiHLUpMZPJjYWz+a1rXuuEdzEi7RHvvRp9mWaZzpBjw38ZDzZvgA/D4leZ8eCNvO1S4HSjyLsLOEmkGrs0KLAs9KUZQQqhsXGIHeexhrkRZFD6xXdUe9tUXOjzlggfOgB8vqcUXKzNfz7flwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357409; c=relaxed/simple;
	bh=qv8kLPuufFADTUcF8iyp3kPRmFJYcjTNoBsImOw28ts=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=j1PfhAAkvGenvmYZG0MpwvE/kgmrwOd+Q3H02KkJt0OQjYYwapQf8POX5S/pOJOnNIQ8mlDgbb1P+JxthsFEcSTI6upIDUdjJ6QQemWZDzCaQqb4P1ng1fnCM1FUAWaDkjkGBSR8+zsu6gL5qTphBEuDXCBn5swilPSpEwIUNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=B+rYC+lM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GA/6HcLy; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="B+rYC+lM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GA/6HcLy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D66D2140019B;
	Mon,  1 Jun 2026 19:43:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 01 Jun 2026 19:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1780357406; x=1780443806; bh=3RSdncHsJoggitGQbQQkVYbi7CF3RBF2qDs
	a24fBKgs=; b=B+rYC+lMZt2wros8paF/qaHZgMU1NitjaF4Hn8H4dHYj+g1XaIz
	HEhmOo7wdZr0ksjdPZZqGpHnXHp3z+Iv6pUwtIGoOyNtrRpk1UI82CGckdYfjt4N
	5saad/cH/queR5DF8KwniiPa9H9h2JhM1+G9xFzY+EZmd13y/2er0PB866lfuEMd
	KkNNAOjFA41zDASKjazA6B62f2/vKWeQRfET0LgA+llecNJIHY67N5d1qaHUoigL
	yC6ZTT3xqz2KNQOaQtXeC0aL7sHPgb7020srHLl7gAA6QsGe4erlarwFOF1V+MTK
	Dozy3x5DnRtJ2Zc6H2hACSEJDYd4rMk50xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780357406; x=
	1780443806; bh=3RSdncHsJoggitGQbQQkVYbi7CF3RBF2qDsa24fBKgs=; b=G
	A/6HcLyszpIeqSTcFqHseAYcuqiJ6KuDi050oDygYbcZHv/ppDqejoItcX6MsY1S
	t/Pzq57Amb0P+UFsPwlqgOnEf7F6Z5h7oRM7GRLvBXc24i78I4SJ/Y7z5kxtGq70
	5xf0UbSEdtajirDP9FbDJVwh1F0koOSMo3Uq6hjekjnN1noKVr8M7+0xGpKK2cyX
	sXjw8oBsP9AFCVO8lG6fkTRY8Y5+7tNr/1pVdqKmZpjK8FuyjIt18Zfl6KcYBsIq
	LJhQLjpCHR5tnTLNddY9NexXiGqtfo/7fcmRTjUttv7+Bbjgvw4hBpmhWq6zqp+k
	5aSP04HH8WIHrEpbbluMA==
X-ME-Sender: <xms:HhkeasQPXuEnK40pPTw32_Nq_0RovQd2pcr0PPOt98nPTSWJSv138g>
    <xme:Hhkeaiso4_s2_N4deOVUydzZS3C-zAQBQqdNmxG2fBIClpcysqDoTdsmClbecYW4Z
    1tZ5XEx1k7x2NuK0NS6ksxvQRrdL6VYxRTHLEih1wZQ0dLdIg>
X-ME-Received: <xmr:HhkealYErP0TkFsGJumQ9I4dL0VAYnp8RvWoOtM174vFf0GSpqaEgeCgZZ5Wm0hJNw>
X-ME-Proxy-Cause: dmFkZTGq388y7o6qMfj/puJc0j8bHXpjDiBbiPdQ6+dcvMQl6g11EVR+kvR7NHeAb3mDTJ
    dHP26YrJofaD69qcRmrf6zhOxgbHWzsUB1DzZa3EC55DoM21BY9v109kZw1PPBrzFg77Fc
    Dbhk+8NcMdoFnxUXNdYqXn/pJ1/brf26lMM+L8giOwu7kC3kmpeGfw8WaHVAxyG/dSthyX
    S5kH3GVmAvu79gLOqLlBKewWaRZ0TR5RuWjp+Or5GQPxwYKesrXkyaeYG9g/A4VJNaLb3d
    Iuf3cmwZO6O6BhK8dhaus03IwuRMiE5yN1CtgWNA6IVEr3KQmZY4Ml25B2bkydfep5RKFk
    ARbpw2OBrWWL8uY4ufOhr4Z7O0OIZilktJdt/BLu1U/c7x1PQiejOy2gdjQp8FelY2CgAh
    3wXT3cv1WD7WujGLu5gMw+7Qxe6hFedePoEl7X+GI5q4UrTXP/I4G14FlqEJYWfA8u/fgd
    IsMMsH3OmfQZz9sBlHKNhz436o0tqGNtNn2/RK2SXENjynnLWJP/T4qrz4wyrw5PxhRjmb
    BUH77dWWM7zkTBFcLGNskuCrn0vTRohzqdpwd5bxslVYXB+JBCBgtFUzG+/Brv8HHaqnCU
    IycOKeTyRepwqjSUGH6sx3+oijK/VLK4mOMPM/N8qcgEFuyUm9IbaPA4VUuw
X-ME-Proxy: <xmx:HhkeagFe3BjqywCdfQ5s3JwvhMHxM0GGYrkRtKhgXGSj2qrBqHteVg>
    <xmx:HhkeahxH-GEB0OLS74NMQ3FdBrNXOGoMSC0__mYASZ7sIPyJTcWYJw>
    <xmx:HhkeaqneVoDL1j8iwLPhU1hJB7iIyRw4TVRYVjcYKmKD6WS-KOODpw>
    <xmx:HhkeailzSunYYMHdlMr3sEWq4DHlVjCSpSXFJJfKIdcwXrmRBhdlWw>
    <xmx:Hhkeat3tA5afLBiyMDPqounHdt7NbahxpcpszCigSnRhY1PxNuS9UdSG>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 19:43:24 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Miklos Szeredi" <miklos@szeredi.hu>
Cc: =?utf-8?b?0JDRgNGC0LXQvCDQm9Cw0LHQsNC30L7Qsg==?= <123321artyom@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: PROBLEM: FUSE_NOTIFY_INVAL_ENTRY leaves stale negative dentry
 after c9ba789dad15
In-reply-to:
 <CAJfpegsCJnMfn_BzzTK7m9ndCGVsnPit8ZsT0fzAhYoY+yOsKQ@mail.gmail.com>
References:
 <CAFbF8N7++zopZuEcsKRxBV_sgOGCbzCY0hOyMw1SiGAtuzGhyQ@mail.gmail.com>
  <CAJfpegsCJnMfn_BzzTK7m9ndCGVsnPit8ZsT0fzAhYoY+yOsKQ@mail.gmail.com>
Date: Tue, 02 Jun 2026 09:43:20 +1000
Message-id: <178035740095.2923901.5908691318688917347@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 01 Jun 2026, Miklos Szeredi wrote:
> [Cc: Neil]
>=20
> On Sun, 31 May 2026 at 03:12, =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9B=D0=B0=
=D0=B1=D0=B0=D0=B7=D0=BE=D0=B2 <123321artyom@gmail.com> wrote:
> >
> > Hi,
> >
> > I am reporting a FUSE/VFS regression introduced by:
> >
> >   c9ba789dad15ba65662bba17595c0aeaa0cfcf1c
> >   VFS: introduce start_creating_noperm() and start_removing_noperm()
> >
> > After a FUSE filesystem returns a cached negative lookup for a name, then
> > later makes that name visible and sends FUSE_NOTIFY_INVAL_ENTRY for it,
> > readdir() can list the entry while stat()/open() on the same path still
> > returns ENOENT.
> >
> > Bisect result:
> >
> >   good: v6.17
> >   bad:  v6.19
> >
> >   first bad commit:
> >     c9ba789dad15ba65662bba17595c0aeaa0cfcf1c
> >     VFS: introduce start_creating_noperm() and start_removing_noperm()
> >
> > Adjacent commits:
> >
> >   bd6ede8a06e89ca5a94a8b51cea792705d1b8ca2 GOOD
> >   c9ba789dad15ba65662bba17595c0aeaa0cfcf1c BAD
> >
> > The bad commit changes fs/fuse/dir.c:fuse_reverse_inval_entry() to use
> > start_removing_noperm().
> >
> > I attached a minimal libfuse3 reproducer. It does:
> >
> >   1. lookup("config") returns ino=3D0 with non-zero entry_timeout, causing
> >      the kernel to cache a negative dentry.
> >   2. The filesystem makes "config" visible.
> >   3. It calls fuse_lowlevel_notify_inval_entry(root, "config").
> >   4. The test checks whether readdir lists "config" and stat("config")
> >      succeeds.
>=20
> Yeah, issue is that start_removing_* all work on a POSITIVE dentry.
>=20
> FUSE_NOTIFY_INVAL_ENTRY works on both positive and negative dentries,
> doesn't care about the inode (or lack of it) at all.
>=20
> I've not dug myself into this work, so not sure what the concept here
> is, or how this should be fixed, but this is definitely not (just) a
> removal op.

This code is quite unique.  It is interactive with the dcache, not the
backing store - which makes sense for fuse but is unlike other
filesystems.
It doesn't do a lookup - just finds things in the dcache which is then
invalidates.

This means the positive an negative cases are quite different and I
think it works well to treat them separately.

For a negative dentry, we can use ->d_lock to avoid races with the
dentry becoming positive.  d_invalidate() becomes __d_drop() for a
negative dentry, so everything we need to do is atomic.

For a positive dentry we still need to get the directory lock, and
start_removing_dentry() works find in that case.

So the following patch is what I would suggest.  It probably deserves to
have some comments sprinkled through to make it clear what is happening.

If people could review/test then if I get positive feedback I can make a
proper patch.

Thanks,
NeilBrown


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b658b6baf72f..3f16ecbc358e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1605,13 +1605,29 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u6=
4 parent_nodeid,
 		struct dentry *child =3D try_lookup_noperm(name, dir);
 		if (!child || IS_ERR(child))
 			goto put_parent;
-		entry =3D start_removing_dentry(dir, child);
-		dput(child);
-		if (IS_ERR(entry))
-			goto put_parent;
-		if (!d_same_name(entry, dir, name)) {
-			end_removing(entry);
-			entry =3D NULL;
+		if (d_really_is_negative(child)) {
+			spin_lock(&child->d_lock);
+			if (d_really_is_negative(child)) {
+				fuse_dir_changed(parent);
+				if (!(flags & FUSE_EXPIRE_ONLY))
+					__d_drop(entry);
+				fuse_invalidate_entry_cache(entry);
+				spin_unlock(&child->d_lock);
+				dput(child);
+				err =3D 0;
+				goto put_parent;
+			}
+			spin_unlock(&child->d_lock);
+			dput(child);
+		} else {
+			entry =3D start_removing_dentry(dir, child);
+			dput(child);
+			if (IS_ERR(entry))
+				goto put_parent;
+			if (!d_same_name(entry, dir, name)) {
+				end_removing(entry);
+				entry =3D NULL;
+			}
 		}
 	}
=20
