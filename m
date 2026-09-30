Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD9B4446F5;
	Wed, 30 Sep 2026 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802506; cv=none; b=mypQP6xpSxOBzgVoQlVd6zRI/1QA48Ka0jkO3azClncGQy+JrUlYJR+OsWktY2GrFqdnXBDuTf+DyHKvjy2Wk6vDtzt5tJnfhN7gTd2oUks2rVJhBdDozXkTej1MUq+AWQC8NqTF8F087ysf2CQB/A3N1uRSZMipp8qITZQOfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802506; c=relaxed/simple;
	bh=Oro7YZioEJC/8uRfD25eK8eqonMW8HDiPDf7Nl4F9JY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hJ0zUFHJpWPKiXOJBaKu0I+fBoWONWlmNBDnubRFOc/LLENWO3iOakRDB8Sge16Ba6vKP+ksjcfwep6fX/hOAMqZFWQvprfndEBUB876IQjY8pnj2K7nc+w4iu0WgnzkbDf0B8onRjNxv5YlEKSSWJW8fnoPhc7wmd9EH9e64iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=AlGfLvMz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZBhtTHu5; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="AlGfLvMz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZBhtTHu5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 069F67A00CA;
	Wed, 30 Sep 2026 17:08:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 17:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1790802502; x=1790888902; bh=/mJWsmetASNjN6EpOjG8Phb840859a2Kyp4
	5AGKZV8c=; b=AlGfLvMz2fKCQKGnh34RIKMVKneOYIqwnhoyv5MeeE2QPHE5gE0
	OEBUlmD3DBc3jqxAZvzgVn901v0Pr4NbYDO2PrqeGf1ffuE5qAw9+y0lcLmPuhFx
	TFC+7bL5QFL4KHd3OjR+OpcpWkWBDU3y5WR4DGDZ6M97us4ZqZcc1h50d4QJSOFn
	yS2Av9N7k38QLJw8rtQl1l2DV0hdfqI6lbXuM+wvGE+D0W/LUPX/0K32qpvbjO56
	So5xHPxEc8PFLCfnFoENuHTMMv1vhH3yNbZDpn59T3dS7eA1pI9ztCdl1Yqlgs81
	ZBqEJx9GIbD+APA98jYkbOFNvZb98uNbahQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790802502; x=
	1790888902; bh=/mJWsmetASNjN6EpOjG8Phb840859a2Kyp45AGKZV8c=; b=Z
	BhtTHu5cUnS1sJJ4d111iSI9kdjOFKSWmqFFoc5ocKjB8yz9ljbRVbw6SbAPRHaA
	rAuoQkuGF/CZGT7PCGXud9nkk7beuXCUtp2++PIm2d0m2JZqGorMdlwKuXR/Nny1
	hQ3TDU8iobSImwF8ZqziEb/XWphky5e+B48Mm3ybf6QkffsWl0BiCswvEFrw9mbf
	HtoTZD5kztKzbMAAU/GRxSOce5CUgipyo6R9wHzyijuumODE+2KMI8qsmqndQIFM
	3+M10YJ3QxmGXcpMmc4rM163kw7tn7g/Z0xR0FL6JnHUtqcFkk4oiiQEdsxjRPgp
	9tuMLtGXAwm4H0gqUW7Sg==
X-ME-Sender: <xms:Rnq9akmaOYILBeSAWvKyYYr2Wwo5Ea4yugV2WUD0S41tjUb_9IMXMA>
    <xme:Rnq9agiTGsqZcIDGUb7POv1iNOlufy2L_JLcaIgLFYol9jruSYcD4wIfxFZUFju8t
    Spre0H4LbQRiEY3UcNVDokLSPBxRoC1GGU5Nx4JH_NUsfcaa18>
X-ME-Received: <xmr:Rnq9amitt-KytCYjYPxg_7dhfMcnKKa3Lydd_Xi-4Q4oEY--zNOkeHwhNZnLPjBfppEAZwyvCWAY-I5drnuq0ZXNfF3Bpf4>
X-ME-Proxy-Cause: dmFkZTEhCJ71Y8f3eLXP6QpBlONgllJkJhg8WVruLNQRCp39HogvcBO6NfmvlXMkYwxWmf
    5JK6nIkXAnxhAAMMkNQrbgUQFxdpu50wsGMxDBYZBmmeUsOOthOuM4D5neqzKuDNHLzabl
    bO9UgEk/AF/mcHVvra5cM5ESWE2mcrh8b6SHROsHYTsj7cgxAaoJznIDY8UG4Khv3dfzc/
    hJbpP1xj8XLVQrMlqAgyG8eZKAqXre83OPvCu/KiOuQOCp1f+7TtC3Qc48jpn0DkSTza6v
    kNjq4jjhTLkXkUXgCT4VuggMfpxgU0b7WtbrUc+c1FeQ3Vjv3P5QZmFvAGkyqXgfHwLfOd
    yMpYIERylXM/qz7XQUkCDe42vZSXgDMAcrQCpP2dXU7tBx0YWZd30j1vc3qWgT7XsPHLoZ
    xTZr2yIMSUkkyrFoqcAGezJzmZop9QeH0m0vbCD6IKPt5yUm4wQgAnZ1oJ+6jahISHTHWH
    d4tGJZIBA/Zv3HHnbI9I0hXT913ObnOCKm0GU2zMU2tl3JUl2O46lSsGdAitzfkhALar1G
    BojvOv85sH1qeWX8Ee0noPn2cTgusBmYPqPmzFShliN7sKXQ4ormkQMccKr/U0Bn5LG/zn
    hoNFVeo7/znCypLVjOjzVIM1TokSZ+CkRA6P1izw/O56cRaA2fK97vuDm70A
X-ME-Proxy: <xmx:Rnq9aqs4pjeipnvLPD_2ofuA6fdfQCGJIA5oay9vBUlO5XVJnB10Bg>
    <xmx:Rnq9amsQy1c8U4oBqOfurJkm5ebL-w4N3PIzmON-dDDXFVP6jlpTyw>
    <xmx:Rnq9agpnWu-c-8C5vZSwXQeHkIfoBRkhPfJG6vp9jvG3TaukzvdZVg>
    <xmx:Rnq9alJjs-qFtr8kIX0JNhrXhRRDAoHz1FyG-dSrgVP3LcvS_XAeHg>
    <xmx:Rnq9ak7yQXkolz89LhHU6LV4n0TEGgv2Yl0C_uAl1tAXbd6FAJgPE5QL>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 17:08:18 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Miklos Szeredi" <miklos@szeredi.hu>,
 linux-kernel@vger.kernel.org, ravitejax.veesam@intel.com,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Subject:
 Re: [PATCH v4 6/7] VFS: add lockdep monitoring of DCACHE_PAR_LOOKUP lock.
In-reply-to: <e3772a51-eabc-4c31-b73d-f3187bf1b3b2@intel.com>
References: <20260904215142.1060510-1-neilb@ownmail.net>
  <20260904215142.1060510-7-neilb@ownmail.net>
  <e3772a51-eabc-4c31-b73d-f3187bf1b3b2@intel.com>
Date: Thu, 01 Oct 2026 07:08:14 +1000
Message-id: <179080249491.37859.6519131410483661870@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 01 Oct 2026, Borah, Chaitanya Kumar wrote:
> Hello Neil,
>=20
> On 9/5/2026 3:18 AM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > DCACHE_PAR_LOOKUP acts like a lock in that threads can block waiting for
> > it to clear.  As we plan to make changes to lock order for this lock,
> > teach lockdep to monitor it so as to help detect bugs early.
> >=20
> > As NFS allocates an in-lookup dentry to unlink a silly-renamed file, and
> > completes the lookup in a different thread, we need interfaces to
> > release and the acquire ownership of the lock.  This avoids lockdep
> > complaining that a lock is still held on return to user-space.
> >=20
>=20
> This seems to be causing regression in our linux-next CI [1] since
> next-20260928.
>=20
> <4>[   10.773931] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> <4>[   10.780181] WARNING: possible circular locking dependency detected
> <4>[   10.786407] 7.3.0-rc5-next-20260928-next-20260928-g6375e61c01e9+=20
> #1 Not tainted
> <4>[   10.793773] ------------------------------------------------------
> <4>[   10.800017] podman/794 is trying to acquire lock:
> <4>[   10.804801] ffff888133cb8388=20
> (&type->i_mutex_dir_key#3){++++}-{4:4}, at: lookup_slow+0x31/0x60
> <4>[   10.814849]
>                    but task is already holding lock:
> <4>[   10.820743] ffff88812dbd3048 (DCACHE_PAR_LOOKUP){+.+.}-{0:0}, at:=20
> __d_alloc_parallel+0x53a/0x920
> <4>[   10.830976]
>                    which lock already depends on the new lock.
>=20
> Detailed log can be seen found in [2].
>=20
> We confirmed that reverting the patch solves the issue.
>=20
> Could you please check why the patch causes this regression and provide
> a fix if necessary?
>=20
> Regards
> Chaitanya
>=20
> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> [2]=20
> https://intel-gfx-ci.01.org/tree/linux-next/next-20260928/bat-arls-6/boot0.=
txt

Thanks for the report!
The log shows that overlayfs is involved.  overlayfs has special needs
with respect to lock nesting which I hadn't allowed for.

I think this patch should fix it.  Please let me know.

Thanks,
NeilBrown


diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e487597337e8..e1448dd776b4 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -163,10 +163,34 @@ static int ovl_dentry_weak_revalidate(struct dentry *de=
ntry, unsigned int flags)
 	return ovl_dentry_revalidate_common(dentry, flags, true);
 }
=20
+#ifdef CONFIG_LOCKDEP
+#define OVL_MAX_NESTING FILESYSTEM_MAX_STACK_DEPTH
+static int ovl_dentry_init(struct dentry *dentry)
+{
+	static struct lock_class_key ovl_d_lock_key[OVL_MAX_NESTING];
+	int depth =3D dentry->d_sb->s_stack_depth - 1;
+
+	if (WARN_ON_ONCE(depth < 0 || depth >=3D OVL_MAX_NESTING))
+		depth =3D 0;
+
+	/* Based on lockdep_set_class() */
+	lockdep_init_map_type(&dentry->lookup_map, "DCACHE_PAR_LOOKUP_OVL",
+			      &ovl_d_lock_key[depth], 0,
+			      dentry->lookup_map.wait_type_inner,
+			      dentry->lookup_map.wait_type_outer,
+			      dentry->lookup_map.lock_type);
+
+	return 0;
+}
+#else
+#define ovl_dentry_init NULL
+#endif
+
 static const struct dentry_operations ovl_dentry_operations =3D {
 	.d_real =3D ovl_d_real,
 	.d_revalidate =3D ovl_dentry_revalidate,
 	.d_weak_revalidate =3D ovl_dentry_weak_revalidate,
+	.d_init =3D ovl_dentry_init,
 };
=20
 #if IS_ENABLED(CONFIG_UNICODE)
@@ -176,6 +200,7 @@ static const struct dentry_operations ovl_dentry_ci_opera=
tions =3D {
 	.d_weak_revalidate =3D ovl_dentry_weak_revalidate,
 	.d_hash =3D generic_ci_d_hash,
 	.d_compare =3D generic_ci_d_compare,
+	.d_init =3D ovl_dentry_init,
 };
 #endif
=20
