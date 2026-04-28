Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0688147D92C
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777404391; cv=pass; b=GHXmxxpNHifA3MqH9p49ahlbx7edLxOVFRze3c0zGWhsOfwh743GQa+EnAMnTjb/sFH1JF5guzGmt8qrKZE6sVZIuRVWIIU74knYwUfNMLHU4sdZKRh2X3z2VWRcZ9IN7PDqyKC8cbkYv6TfZB/DeVWaP/8Bhy9XV7W69ySwzhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777404391; c=relaxed/simple;
	bh=U/O8kY35FSPyilg0S9fhApP710nRPp9xFdci0TwAFQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1EashDP9xKxYAmsIxFVrHswUCYWGtWTb9QU/nV5ztV+S3RirfA3xixP97TPo2l9yZSzCl0RQ/Fae72IGqVd3kMbK9YSk/tkH8//ietAMMTe/GSYX80slAeZXtVHvGvM7mfgllK8Shzx5ceexk4AUSlNPTn5DM9/0dgwJTfapKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q7vwjsmM; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q7vwjsmM"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso8203857b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 12:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777404388; cv=none;
        d=google.com; s=arc-20240605;
        b=RRVvjVNKlJpndplbSTygiAfgVyMLCYHvdC7NqJz1PU39qqu9wonC1EWiC3nViwqF2c
         RbAAp0zHVUCCqMn9z0bd3x5LL+tRrFal4uIGL616e63qjSDDChSAGMRn8hI2Z6tGmnUr
         herNjiy7kvgfVrcJCLaL3RPQFExLs8YKb3nx+OQk4La5lgArm2xmCyvAl/PRGlfRh/pc
         EJCV6mAg/T98K94IF2zPjUAxIeZenvrxbxKoItKuwlfhYHeNI3l+OasIeuYVOXiEgmNr
         ElPggTV/7yt/TDQ4Ll7GnCiLxRZAE86hmFLsRZd2v9iELt2fiB2QEuTlpFSZQ2icBEi3
         bO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AnfM8zUa1lWAp+XFfhTnKVtdHMyqVSknxxMlh2RVx+s=;
        fh=ZxfAOWJUX48KGmObUNKxoYIi5cgcTjD5pGqBuHvhXs0=;
        b=Fb1KUQ+ZNRZDOEpk11nXQZJz3VW5UmUYbi9avENPLaJi/pc7s9vJcVrcGw+oyLrgzj
         cnydFJOE3siKyvbYOKquSdAg6v1Y5kylF18KjFjw1f+x4RXEwgVlBm5Nw/iUdQyYievf
         Hlo1YtczsAd9dxtxTkM4ZjS/qzga4cqoNbzMBwys/r8aZ+xBIR1Hk2aBaIhzPIYZTZOt
         bKlkXcBBX8sNpZxUO3foVs3ErMPMNMmFi3RqfgXkgcuz3hEtvl2KAWam3au4hIpRVR/e
         G5r2dfaRttbs5UPxg3WIOF8Rjpi4ujbU2hx060eaFnWZbYdFVaf8rb2IZL7lOj+R5M81
         ocrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777404388; x=1778009188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnfM8zUa1lWAp+XFfhTnKVtdHMyqVSknxxMlh2RVx+s=;
        b=Q7vwjsmMKcT1l9AXMv9x+KpTvpFxUKicUV6cTZMYhfBbNByB0fZF26MMPg+TFYXldO
         wAJnS+xEWXJ9B32JBTBrBIiic2/TeFFLzWJgSXX971s8U5GdjVU5swP5jQNe/htLdkI3
         ZdgeBBL205oAlmG8o0ZHP3gwEnRf6+CuAq1bnKD7K0LesxTfN2B6HATKPShdePiNxe9l
         5IKU/kkmPcPleMi63gfxcs/0a3ucVgI8dCjkUP2X6731EBcWvHp3wHrzOUzZpdkcqCUB
         hKkLZBo5SE7N74E8O4Q5Nvc3gLmrBdIjySsJTh6B0ctBuAz0XLTvOffHG0QD5sJswMLI
         q6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777404388; x=1778009188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AnfM8zUa1lWAp+XFfhTnKVtdHMyqVSknxxMlh2RVx+s=;
        b=blb4vorQPhFQ2Aq0Aq+fU5lwmdjGTp2rxqQjkCJHYRRSMgXqDBOZtzdovUvQlKeU/G
         bg5ktaOZaJa2C8Jz6rDDZWtbZOt0TSMy6gzYi1ywjcGNtu9WHTWpGeC71DxucAphtjlC
         WsrarSs3jBmE+S8S55yCUJz3A3qO+ub9B8L5QOjRXyA3ZgvT8H9etLHgIFHceUV1uYVT
         UKfQ14Yvm/Zo8Z2nDIUhIgoVYGJEVoTuI8ncDmo8SybeLP6I8taEZIEBKXfEzlTvxhBA
         kFSK7o1jBNShtIye5go5Hw9m8WwlYS130axDBp1+LIwA6rgHmz4ErPZFiUSxW/kvDrgT
         bAeA==
X-Forwarded-Encrypted: i=1; AFNElJ+vraYdLVFtlPPQS1/sHMcOT+X42/bjkOKDaRK0B3KU/d0iBFnbaLCTwBeM4Mg36VsYvo8JRF9DztMzA0Ef@vger.kernel.org
X-Gm-Message-State: AOJu0YxamdFRyC8PNTVr8HYQRuMKUlXj1rNm0LzT+uFqQFPht8+Qt1N7
	rZKg+N+qJAOpq8DERlSDV3+Ygj3GHOG0waX7uii0su3NYlrWMAd0AH5kZk6PNwxEXvxNCBf28F+
	cU8gYF9uCtemSqDd6qXR7h28HFN1Mxk78ILXWoYQ3
X-Gm-Gg: AeBDieuP3jmCBhzPb4V2ehIjSR+udkf4YsGN3N+5yPUn9jZp6MlxjnVMUSlsZ28mWsy
	MDbDgefX3/hdQAYATLRSS3k9E9r9L/dO3BVAVuILTOVq652IAZ3FDMT1pfxL1mzumutfUyBWx8H
	ipJj2s/QdEWrye8ijC3KK8qIQmEAQ8D9WXExWkbiY1xvOnT72KxltlX5L8SQlw+0Vre8Zk56Yxt
	bKQ7R8MF0jmrkJJssaYk4zILY0smpRCFPYL06UzKKRlQO8sNC9npnRVtzWHMK+nm8PkQK4CM9W1
	VLr7ZFgm9GD/su1XWQ==
X-Received: by 2002:a05:6a00:b610:b0:82f:5f2c:dc1e with SMTP id
 d2e1a72fcca58-834ddbefc48mr4513385b3a.30.1777404388228; Tue, 28 Apr 2026
 12:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com> <20260428192119.226244-2-paul@paul-moore.com>
In-Reply-To: <20260428192119.226244-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Apr 2026 15:26:15 -0400
X-Gm-Features: AVHnY4JfXj5rdz057afaM2yOoDKKiXKQXh_FDv64DRP8yW2NVR2QdpNqmASHI1Q
Message-ID: <CAHC9VhSDPg2U9UYZ7Na_A8RA-KN8OsNj5S+QwscW6X20tojhjA@mail.gmail.com>
Subject: Re: [PATCH ported/repost v2] security,fs,nfs,net: update
 security_inode_listsecurity() interface
To: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc: stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 3:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> From: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Update the security_inode_listsecurity() interface to allow
> use of the xattr_list_one() helper and update the hook
> implementations.
>
> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.small=
ey.work@gmail.com
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> [PM: forward porting to bring this patch up to v7.1-rc1+]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/nfs/nfs4proc.c             |  7 ++-----
>  fs/xattr.c                    | 11 +++++++----
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      |  5 +++--
>  security/security.c           | 16 ++++++++--------
>  security/selinux/hooks.c      | 10 +++-------
>  security/smack/smack_lsm.c    | 13 ++++---------
>  7 files changed, 29 insertions(+), 37 deletions(-)

With the security_inode_listsecurity() cleanup shipping in Linux v7.0,
I wanted to get this patch ready for the next merge window.  As
expected, some borderline non-trivial porting was needed, so I'm
posting the ported version in case anyone wants to review the patch
again.  If I don't hear anything over the next few days, I'll plan to
merge this into lsm/dev later this week.

The SELinux test suite runs clean for both local and NFS test runs.

--=20
paul-moore.com
