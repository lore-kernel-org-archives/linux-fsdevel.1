Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490493;
	b=anAhC4wb32pdwJOrd1g9Dati9530FnLj/hozX/U2+XqkENhdgl5kzoQ8S8K7rNEHYW4Y
	 kpvKizFYrSG17lrozIuo22A/LgTA6LrvRYELX0LWXJqyHIljORXiJ+fvNfZx+vzt25f4W
	 LZ3ibtm+/QGza1TuPatB1xAk6Vk+vwN6ipObreyBrTFtO9ypfF8IQd3HrYorVaEyCjYEN
	 aQNb9jJXo/pSodo/XOsF9PpbfIVeF19NPWLZcJOD5bELfINEFnkOatEiir9BPqfKh0wdm
	 3Id+OEMsfO6Kr9xv8mU15hVoDA9knzMTBXokQDLGVia8OlUvf8j/C1iSC2TEEy6mXuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490493;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4eTucFZNSL9MZwK8+YG2mr7BhDfI+QpIeohJvthNO/w=;
	b=wXZIMhkCGj7x8JASrD7qDDQWqX4gIC5SReUkQd57Od8Lp0oS0l0xQfOSC5NleStsfbeM
	 lKK96hoK0Oq4U/+deDYehWm+X0Mny6x20xBIW5rc7xZvq9TM8bKhjJXaNjQlcwjrUjQQG
	 Z+lTWEYSWL+dBLM304BVq80JDnEvRmVWuoCS041SXaqbxfrQNS+yXWr5n9vyShsv0zGz4
	 jgnOyCKmeShNTE94LIzDsK53YzoVAMQjx4hbQ1R+vT/5G8/W+mpPuKR6UkDGn+8RJiOyH
	 2dFub22obdoth+/EoahjmztzRNG+yr+3pB+x8DIRsFw1uH8w5hQh9okA+lBa9TXLr6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=J2u0+xam;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E52C606A880;
	Thu, 12 Nov 2026 13:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E52C606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=J2u0+xam
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=4eTucFZNSL9MZwK8+YG2mr7BhDfI+QpIeohJvthNO/w=; t=1794490492; x=2109850492; 
	b=J2u0+xamrt7FAFn7MUDbQ0AwGFc4Sgf1Gv5u162NCQ+AkgdLia+QDIxc0GpeGsqBMhE1lUZCMCl
	lWbdNU4ECzHPbwnCY0x1I7X5q2l4+Y1gK/z8VLw6uBQhAITJKb/+HZrPhOP6TbqYDQ/Ht91IPOq9Z
	F5Bv46n/HAwC6idPgSQwwO1lgBGacE6DJ+2KL5jUIreA3p9A0WE/Bew1hUTUXXmDpwXFFk8IQQYAl
	FfAF8gw0mDdqkk8em9OjRsQBCozBdF1ct5dQwcNrF/dlyd5YWazAdgp+3VGGELi/A37lOuDihb2ag
	CdMWLiclji8waJNFPp3FZspr461ZIJNBN/DA==;
Received: from bl16-24-61.dsl.telepac.pt ([188.81.24.61] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xRUwt-009YpT-Vp; Thu, 12 Nov 2026 14:34:44 +0100
From: Luis Henriques <luis@igalia.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: mszeredi@redhat.com,  Shuah Khan <shuah@kernel.org>,
  amir73il@gmail.com,  linux-fsdevel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  LKML <linux-kernel@vger.kernel.org>,
  linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,  nandinih@linux.ibm.com,
 fuse-devel@lists.linux.dev
Subject: Re: [BUG / BUILD FAILURE] selftests/fuse: build failure with
 libfuse < 3.17.0 (RHEL 10 / fuse3-3.16.2)
In-Reply-To: <bc84cb05-55fe-43e7-9a6e-e6bbf2f5a9ff@linux.ibm.com>
References: <bc84cb05-55fe-43e7-9a6e-e6bbf2f5a9ff@linux.ibm.com>
Date: Thu, 12 Nov 2026 13:36:27 +0000
Message-ID: <87ld6yxjc4.fsf@igalia.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Venkat,

[ CC'ing the fuse mailing-list ]

On Thu, Nov 12 2026, Venkat Rao Bagalkote wrote:

> Hi Miklos, Luis,
>
>
> IBM CI has reported a build failure, while building selftests/fuse, due to
> missing definitions in libfuse3 headers.
>
> Environment:
>
> OS: RHEL 10 (ppc64le)
> Kernel: upstream (linux-next / mainline)
> libfuse package: fuse3-devel-3.16.2-5.el10.ppc64le (pkg-config --modversi=
on
> fuse3 -> 3.16.2)
>
> Build Errors:
>
> In fuse_acl_cache_test.c & fuse_symlink_cache_test.c:
>
> fuse_acl_cache_test.c: In function =E2=80=98fs_init=E2=80=99:
> fuse_acl_cache_test.c:105:17: error: implicit declaration of function
> =E2=80=98fuse_set_feature_flag=E2=80=99 [-Wimplicit-function-declaration]
> =C2=A0 105 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fuse_set_feature_flag(conn, FUSE_CAP_POSIX_ACL);
> =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~
> make: *** [../../lib.mk:226:
> /home/upstreamci/linux/tools/testing/selftests/filesystems/fuse/fuse_acl_=
cache_test]
> Error 1
>
> In fuse_mnt.c:
>
> fuse_mnt.c: In function =E2=80=98test_readdir=E2=80=99:
> fuse_mnt.c:51:35: error: =E2=80=98FUSE_FILL_DIR_DEFAULTS=E2=80=99 undecla=
red (first use in this
> function); did you mean =E2=80=98FUSE_FILL_DIR_PLUS=E2=80=99?
> =C2=A0 =C2=A051 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filler(buf, ".", NULL,=
 0, FUSE_FILL_DIR_DEFAULTS);
> =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^~~~~~~~~~~~~~~~~~~~~~
> =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0FUSE_FILL_DIR_PLUS
> make: *** [../../lib.mk:226:
> /home/upstreamci/linux/tools/testing/selftests/filesystems/fuse/fuse_mnt]=
 Error
> 1

Thank you for your report.

This issue was already identified and fixed by Sasha[1].  Looks like there
was some problem when my patchest[2] was applied to the git tree:
commit 3e14f079d7a0 ("selftests/fuse: add fuse symlink caching test")
dropped the actual test code that was present in the patch.

I believe Sasha's fix wasn't yet applied, but I guess that will eventually
happen.

[1] https://lore.kernel.org/all/20261026194008.274349-1-sashal@kernel.org/
[2] https://lore.kernel.org/all/20261001164916.15311-1-luis@igalia.com

Cheers,
--=20
Lu=C3=ADs
