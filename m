Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801991;
	b=og02SH9LgQRFsRim0PhkEIPz3ZIkYJrRAnYgXTm3PPpqs3CFEdRpjOoERqsP7zKiJ/BO
	 P84NJxL3zMO2CthFEzchJoKGZ5B3JmqtCdi+lgRFlw/uJT8FzDVkcbylwOHQxp0TPkqzw
	 sDcSUmy/1B9rdL4UOrzhckBqyXK+NRNyTgWO1why4lgwVhky6Y+0WTonH/ZTirlqhAmv8
	 S4xR4OIIWd0DtDmrnMoaaJurcGl0c+91yGS3QGq+80fZ6xBbVKT6xcWP/VZpxfEVHUGrN
	 WmvfEjhCfAZVFvuAblu8xhGX2xYtV0UBS3fZaA7yrhzlvI9wFPpKTy5ieQ4e6oJtRNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=YbrJuZEMhARstEupCVWU0DhIXaBmHViQoAYzcKNfsOM=;
	b=YvMrf1GaVPjw/N6DoGYQuJUVcnFQc9DmTKjp6Uvox69ieaN56pSSCcDIJ0MOp0oXa2FL
	 ujfFrmR4W7iNwAax9fH2e9/neTjJOz/8Jr1iC6/fZbazXHFzPP01k/RyZtOizo4e8TbmE
	 TLiBi21ss6r8gzH3WA7RTfiSKvxQZokwyAtqRGhi2xvD3WyeTDkyFp2N91vsK8UQ3t3iq
	 qpPLGNLnT62ir5FFWIew3D9OkVsg3gOPjF8vYqe3LIrmVUKoBMjzqy+xP80yn5y/LIag0
	 GAZPo1m5eZAfT1nRnKJIs5FsfjZC+WJsltOfjSzqdKjtsjRo70D+yUpnAPlOZZrqM1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XqGwfLa1;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BE4606A31F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 17:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76BE4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XqGwfLa1
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b4cc793704so65811197b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 09:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795801990; x=1796406790; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YbrJuZEMhARstEupCVWU0DhIXaBmHViQoAYzcKNfsOM=;
        b=XqGwfLa1x+D87QuNjXc3STVXQCwlI7b+ALlghhoR3qaGiEkDu1IkGQTVxwYicKtg5z
         jb3/okLuFgV9l6E0R+AAblNKirURaT/8Fj9JUDQVwvSg3oGNPx65akzDFpXkihlcVDkz
         ic3vZLPSLhmmcrVd52wdVqWUKt/YoLKEywbcq67LahocCVlHdEMei6mYJxScrqKyR/p1
         B8ntmHtneZYepStIZ2kif3ddAiRQL3+LkP8vjbaeYShA6eS7nnXj4u3W8QwYwwDHFaVD
         CZI3YD2MLcv2o/+wWJnV4WCqny9of4SzQQBHUAth0YfgA6UIJR1eB5+m5YLyQcqDNA3m
         Yh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795801990; x=1796406790;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YbrJuZEMhARstEupCVWU0DhIXaBmHViQoAYzcKNfsOM=;
        b=iR4mYbcf71mrwBalsoY3EXKypTkr4+ZghFS8dOwc4KsGg29Moy7dlmEchHXEJ55Rue
         S22Mmnio2govqutG5KRpfp/TpkW7eSCFGO9Lxql0SCV5ZAEbCxcriwTZg/OOsVG4Fn4K
         CgtOa1W3yqxS0uwTE4ae4RGwHMECnVhIbAHkCtQu6nS51XhinLc36+UrrILvMPPs5XY/
         4AK1UPHhr5TFV+v1x49+iVorKtcBmyZp4LbzrXrBYVw0EiqPTyY+haavE5bP+EWXSFrN
         vyCl54rwnUd6LVZcoWzIOobqmN2qIkr7CE9m4ZYyefxBYX4xrC7IRxJPjqGWgQMXQN+G
         vnoA==
X-Forwarded-Encrypted: i=1; AL+hErGkUPAP77OCbkTGGjcHqxHMYQ1nCLdig2TPSXSqQuzgZHLFgsCGzTAhypKgjmMEhrsy9TicJ17dleW2OJPl@vger.kernel.org
X-Gm-Message-State: APuU4Z/bwUyFSBTtDo9la8W68z49y5k3dCFBBTdlPf/2OrtJSJo6VdjZ
	NLqIjlQghxaSMU3zmVGIwWSuSTE2VoyicDwBMBU6MRpGBModO9mvCD+cnxkyC9e/Aqs=
X-Gm-Gg: AZFdTZcuw+pI4Z0oS2lIPPoC5AcY3Fi0m1DFRgAD3wyHPBNf3fAueNTgJh7TriZ6C/V
	wJQhqdWTam1P90IM80j+RnL/WIILKUgaWKkesIGMBb86ke9jYO6avApO2pq6BUx751ve2Yd28cS
	qiVQXYCMfaWSKAKMzauFyblIQRo9P8oxJDIxzxDZw1xUdeGvbr95SvxvVMoELRxiI2yZdLINSPD
	jbK+jDPnsWyLYSSqWCIcZgdE1nWvi5kiRyMVISOOi21ezmD0K7C+/Q0e/9DfZhvpQInA+uzD7i1
	XCPdqyuzjxYE/YA0UavLVGAt7B2HJjoSforsYGf75zfjzSayjZEBUupZQkud473is9DgkQNConC
	pv2oGEXtrlWHhLDxlFq5WMwO0VqUpPZbL6kuKKnTW0Fb0FrM04hQBPNMyy6Qaxq67EkGL5hVB9V
	pS2fKAl72oa75DUhNs0anC6vpVc+zcJE6pJaGpG+mT9Wx5bW5Esftd0iT7Tx4HUy/pQ+e2voa/L
	biTFGz1khnB4wzZNL6D31bdDd2maf4BfLlXWGAz4et/EMUIwQoth5q3NK/5zYzuL3xcMGn3RkFt
	RoJ/BK0m0TVG9R5w6YHLh95OoEyRiKoZ4lBSyChU2tdPzTbRgsKVsFLil2a0aDPQQz3Tmng3Sv3
	cvBrPH4dKkOPdurum1IVSnXSD5XUqdfpOrtWHlhFG2Xb5TjuUuRU5B/u4VTMD4ULencOySrbY
X-Received: by 2002:a05:690c:dc1:b0:8b3:23f3:134d with SMTP id 00721157ae682-8b5204ba154mr89112077b3.42.1795801990329;
        Fri, 27 Nov 2026 09:53:10 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:1a5a:d5f7:70f5:514b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b56fc6131fsm35622287b3.34.2026.11.27.09.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:53:09 -0800 (PST)
Message-ID: <0e5898598e12940f4b33aebccabb6bd3a42565f2.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: reorder complete combining runs for dentry keys
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: kernel test robot <lkp@intel.com>, shaos <shawnq1@163.com>, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2026 09:53:08 -0800
In-Reply-To: <20261127114353.IlT3o2gb-lkp@intel.com>
References: <20261126160720.3007837-1-shawnq1@163.com>
	 <20261127114353.IlT3o2gb-lkp@intel.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Somehow, I don't see this patch in my email client. Please, fix the
issues and resend the patch. And, please, double check that you are
sending the patch in plain text.

Thanks,
Slava.

On Fri, 2026-11-27 at 11:52 +0800, kernel test robot wrote:
> Hi shaos,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on brauner-vfs/vfs.all]
> [also build test WARNING on linus/master v7.4-rc4 next-20261126]
> [If your patch is applied to the wrong git tree, kindly drop us a
> note.
> And when submitting patch, we suggest to use '--base' as documented
> in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:=C2=A0=C2=A0=C2=A0
> https://github.com/intel-lab-lkp/linux/commits/shaos/hfsplus-reorder-comp=
lete-combining-runs-for-dentry-keys/20261126-160720
> base:=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git=C2=A0vfs.all
> patch link:=C2=A0=C2=A0=C2=A0
> https://lore.kernel.org/r/20261126160720.3007837-1-shawnq1%40163.com
> patch subject: [PATCH] hfsplus: reorder complete combining runs for
> dentry keys
> config: arm-allyesconfig
> (https://download.01.org/0day-ci/archive/20261127/20261127114353.IlT3
> o2gb-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 16.2.0
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20261127/20261127114353.IlT3
> o2gb-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/20261127114353.IlT3o2gb-lkp@intel=
.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
> =C2=A0=C2=A0 fs/hfsplus/unicode.c: In function 'hfsplus_compare_dentry':
> > > fs/hfsplus/unicode.c:747:1: warning: the frame size of 1456 bytes
> > > is larger than 1280 bytes [-Wframe-larger-than=3D]
> =C2=A0=C2=A0=C2=A0=C2=A0 747 | }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^
> --
> =C2=A0=C2=A0 fs/hfsplus/unicode_test.c: In function
> 'hfsplus_dentry_combining_reorder_long_test':
> > > fs/hfsplus/unicode_test.c:1547:1: warning: the frame size of 1680
> > > bytes is larger than 1280 bytes [-Wframe-larger-than=3D]
> =C2=A0=C2=A0=C2=A0 1547 | }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^
>=20
>=20
> vim +747 fs/hfsplus/unicode.c
>=20
> d45bce8faf5551 Duane Griffin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2007-07-15=C2=
=A0 721=C2=A0=20
> d45bce8faf5551 Duane Griffin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2007-07-15=C2=
=A0 722=C2=A0 /*
> d45bce8faf5551 Duane Griffin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2007-07-15=C2=
=A0 723=C2=A0=C2=A0 * Compare strings
> with HFS+ filename ordering.
> d45bce8faf5551 Duane Griffin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2007-07-15=C2=
=A0 724=C2=A0=C2=A0 * Composed
> unicode characters are decomposed and case-folding is performed
> d45bce8faf5551 Duane Griffin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2007-07-15=C2=
=A0 725=C2=A0=C2=A0 * if the
> appropriate bits are (un)set on the superblock.
> d45bce8faf5551 Duane Griffin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2007-07-15=C2=
=A0 726=C2=A0=C2=A0 */
> 6fa67e70755930 Al Viro=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 2016-07-31=C2=A0 727=C2=A0 int
> hfsplus_compare_dentry(const struct dentry *dentry,
> 621e155a359196 Nicholas Piggin=C2=A0=C2=A0=C2=A0 2011-01-07=C2=A0
> 728=C2=A0=C2=A0		unsigned int len, const char *str, const struct qstr *na=
me)
> d45bce8faf5551 Duane Griffin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2007-07-15=C2=
=A0 729=C2=A0 {
> d3fe19852e96aa Al Viro=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 2016-07-29=C2=A0 730=C2=A0=C2=A0	struct
> super_block *sb =3D dentry->d_sb;
> bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18=C2=A0 731=C2=A0=C2=A0	int ca=
sefold
> =3D test_bit(HFSPLUS_SB_CASEFOLD, &HFSPLUS_SB(sb)->flags);
> bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18=C2=A0 732=C2=A0=C2=A0	struct
> hfsplus_decompose_iter it1, it2;
> d45bce8faf5551 Duane Griffin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2007-07-15=C2=
=A0 733=C2=A0=20
> bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18=C2=A0
> 734=C2=A0=C2=A0	hfsplus_decompose_iter_init(&it1, sb, str, len, HFS_REGUL=
AR_NAME);
> bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18=C2=A0
> 735=C2=A0=C2=A0	hfsplus_decompose_iter_init(&it2, sb, name->name, name->l=
en,
> 897c2beb4a7799 Viacheslav Dubeyko 2026-03-23=C2=A0
> 736=C2=A0=C2=A0				=C2=A0=C2=A0=C2=A0 HFS_REGULAR_NAME);
> d45bce8faf5551 Duane Griffin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2007-07-15=C2=
=A0 737=C2=A0=20
> bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18=C2=A0 738=C2=A0=C2=A0	while =
(1) {
> bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18=C2=A0 739=C2=A0=C2=A0		int
> c1 =3D hfsplus_decompose_iter_next_folded(&it1, casefold);
> bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18=C2=A0 740=C2=A0=C2=A0		int
> c2 =3D hfsplus_decompose_iter_next_folded(&it2, casefold);
> d45bce8faf5551 Duane Griffin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2007-07-15=C2=
=A0 741=C2=A0=20
> bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18=C2=A0 742=C2=A0=C2=A0		if
> (c1 < 0 || c2 < 0)
> bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18=C2=A0
> 743=C2=A0=C2=A0			return c1 =3D=3D c2 ? 0 : (c1 < 0 ? -1 : 1);
> bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18=C2=A0 744=C2=A0=C2=A0		if
> (c1 !=3D c2)
> bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18=C2=A0
> 745=C2=A0=C2=A0			return c1 < c2 ? -1 : 1;
> bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18=C2=A0 746=C2=A0=C2=A0	}
> d45bce8faf5551 Duane Griffin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2007-07-15 @74=
7=C2=A0 }
