Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD33B19AC
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289982; cv=pass; b=FfJITMm3zxZ3IRFxU9xLS4SNYcTNL/TkWv6hQSiltxE3nJEswWnGrF2x584zKdKpobi/LW7q1xp4tTMAOgr39jWRSqWn8ZiMabl17zVockWSmdgLXyVALUWOfNORtfd3EvJEaKgITT2o0hnthQFCkfOetU5fwg/1TUp7ROJ3U2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289982; c=relaxed/simple;
	bh=+yYeRlTixVTmGFmRG+s5A86BDKFtiup5Vt8UVK+qDgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLGE9Tz1JE/+60BVXLYTaL8aJUDP6FXhkzCBhLmUnoogYaKT+fz2Fx/QxGW4DfVcyRj7TaPTexZKHy0nNUUVgOXrNWQwEzcNs8sR1h/HtvdP2AuHMuEz52427VDTqLEHtFkbyaWdLcorIe6dD2xv5GCWmHkZoqCMA/THUtx79TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qK+5ZZ9M; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qK+5ZZ9M"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b6c45781aso118431cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 11:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774289977; cv=none;
        d=google.com; s=arc-20240605;
        b=bz3n9uJSlUl5ulp3+muGhUrFPzNnwaPTGoD2YvoZI/avTjlXWnTEgqUHoQWGRjtU5B
         vVYNkMZBzI3o4cb/bYKUE2DxRyAZEvysbis3FK6zHJNOxTfX/CI/5iYkoC8PytUQHCp7
         gg6KE9mhQzBsE7AUzJm9GadyAAvuxxYGJz0w3d99Uq0Gxtjqu1Nwg3x+noA9f97FLFjq
         /gUF0q/UL8CuEZ6YbEZbcb++iJEq2Es4TJUy5CypEuV05bd0/cAi6Ts8iaTuJGrBTJ7F
         ZD87Y4rzNHcJb/a3xbtXHrkgv9iA3gERKyGt8iXmHfspEYlaRnKDgLhIdfj3P//Zx/HG
         rdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rpME3hoPAsp8yjWyK8G0DnmZShEC8d8jtzVq9X3h7nk=;
        fh=vIHj6gcLxsDlfzk/1p0hBJ+FKY57YrcLzG+0Ufz/YyU=;
        b=Ytze8cJoWhBpn19A4HE8txiUGN5sd0frVwd4z9bDDH/4TFFTM7BsNC8l5JVGSZhXRq
         2VB50cmCxY2mdDTjl2ShndxJUmCQ0zMfIq2mkl4gxp89hGMxRe/k248M0WY5r1C55VCo
         7CCScCtHdUEa2ufxkcGYOSUeNbV3tEh2w1nsLVHt+cWGJBHztwJbYqcfPq5WlrA0NrZt
         udDo9qXGISyXPuaYAXvaeleSagFyYiHJYE3mLot2q+/pJEYKNzLL4N/GpR91o0j0pP+d
         CYGLYrpHA+DG1URrssqs/n6RSa5rO79OxXWWjC0j0Cpqnd+E01lkmBuI3Ctb0YUBEv6r
         tiXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774289977; x=1774894777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpME3hoPAsp8yjWyK8G0DnmZShEC8d8jtzVq9X3h7nk=;
        b=qK+5ZZ9MhCTE6fXvVStDM3BTTgMNyzTFgm9OD2R15UU09+jkfYw6ppAbArebki4stM
         CVu6EfTMT4XvzJCIzll0P0QX+vsX9JXaA//D+58XXpBOMR0TyAkjaKadMQO0AfEgi6G4
         +08jfTpwClJrqlWSq7jqP6+ulWmbS9hHJGISGEnard17NJQUQHKGQ9qcUqYCG6Vzu0XP
         hl1QWnQeIpPHJ8idHa59EDUof4U+d0JR26JqO26E9qiG8C8S7rrMTuhNmV8pSQXUO1nF
         O46uyjNJ7506GrxUrv1k463PZNcUpEEMEWIoGcReOZbWws1R7sAtW/nONBZKyfXrX5Dg
         jWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774289977; x=1774894777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rpME3hoPAsp8yjWyK8G0DnmZShEC8d8jtzVq9X3h7nk=;
        b=HZPMZNxeDPV7mQmsg/+PBWwRttc4vw8BE4AU6IaqIudpZ9wijCaxeM2uz0j5hQ6Wy9
         s0OuwU4kElH2J6Qeh4tnyCXMfd4ZgYv8dH3DPXQ9XfGe+ef1r+MmEyl9dYEik2rwK6cp
         4Nc9ETVczFgabYxqCf0KRouaU+iCXUzEhjbuhB9wmIDLFS11KijulHv3oJPPov96KWNB
         fuHDPYbbSlgNxYoq0mtNr6/HorfKWuEER0sbyejV1hisofrDE8Wu6AGkQKlX7KIXrzIi
         t5kTyeg9IT1J+rGQghBzen6B1uyRI4d9VE9YPTfAXmtX+x06zhv/e6GsxngYJVz+HRAV
         qIOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuxvhsta2vDRIWbLvB4E52EtJI+rhxb/U8tw0qGVaJt8O99istEs5aTSw64WNWxTwiY/9Atbs8p1E5kcMT@vger.kernel.org
X-Gm-Message-State: AOJu0YxFVpwe0v28AmNSBjrkngoSEJS6LKlb3CLPBtuL8Rm8GNLEWDL+
	D8BXiV8kR5LBk71uuVjOZnb40hVxpt/kOFOmYPBTR9/Hb7tdPLSyzSCm4c1KphADvbNrulMKAz6
	CXaZebTuJmv9OwZ9jjWP/7Jw+yuR8jlmXAGjmLNyP
X-Gm-Gg: ATEYQzwCV0V1+89Txx5o3MDx8dve05R4OpGUS7U9J/oRS1xD53ZvYyVPLMejEm0B2oh
	3w45ZNIUhW46lnF7KNqXAt4UwjynE94TmrsRR4PobGL5mUz9QXeY6tkgOzjx0cIzfpCRzNFyT32
	R5x5gn2qY+62GjdASwjsfXV2h7QMsdbUsEu++TQZE34eLO9cVNPp10UtyrIiGFOAve+698rnpyt
	tT0dSY29IhrRADycgs57vRgKX1qLzeskjJKOh3o4LTdZxhrzpnB+9e7GDLIf6qk2oUY4zAoGT+q
	dIRM+2Q=
X-Received: by 2002:a05:622a:a6c7:b0:509:1d4b:f86f with SMTP id
 d75a77b69052e-50b6fc209e3mr1241661cf.14.1774289975825; Mon, 23 Mar 2026
 11:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217180108.1420024-1-avagin@google.com> <CGME20260320091528eucas1p14a64767f916b556d30cfa00bfd320ace@eucas1p1.samsung.com>
 <20260217180108.1420024-3-avagin@google.com> <aec9c36d-d67a-4b61-9950-57b95afedf75@samsung.com>
In-Reply-To: <aec9c36d-d67a-4b61-9950-57b95afedf75@samsung.com>
From: Andrei Vagin <avagin@google.com>
Date: Mon, 23 Mar 2026 11:19:24 -0700
X-Gm-Features: AQROBzAhvewwaxO75KtHSJHA6EI49ZdtMgsJux-PiYZ7CKyEB4qJVMgkX7DDUX4
Message-ID: <CAEWA0a7s86fO_gezFRWGjXh5i0-=XAuo+7pqqf3CdWRX3kBwGg@mail.gmail.com>
Subject: Re: [PATCH 2/4] exec: inherit HWCAPs from the parent process
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 2:15=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi,
>
> On 17.02.2026 19:01, Andrei Vagin wrote:
> > Introduces a mechanism to inherit hardware capabilities (AT_HWCAP,
> > AT_HWCAP2, etc.) from a parent process when they have been modified via
> > prctl.
> >
> > To support C/R operations (snapshots, live migration) in heterogeneous
> > clusters, we must ensure that processes utilize CPU features available
> > on all potential target nodes. To solve this, we need to advertise a
> > common feature set across the cluster.
> >
> > This patch adds a new mm flag MMF_USER_HWCAP, which is set when the
> > auxiliary vector is modified via prctl(PR_SET_MM, PR_SET_MM_AUXV).  Whe=
n
> > execve() is called, if the current process has MMF_USER_HWCAP set, the
> > HWCAP values are extracted from the current auxiliary vector and stored
> > in the linux_binprm structure. These values are then used to populate
> > the auxiliary vector of the new process, effectively inheriting the
> > hardware capabilities.
> >
> > The inherited HWCAPs are masked with the hardware capabilities supporte=
d
> > by the current kernel to ensure that we don't report more features than
> > actually supported. This is important to avoid unexpected behavior,
> > especially for processes with additional privileges.
> >
> > Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
> > Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.i=
o>
> > Signed-off-by: Andrei Vagin <avagin@google.com>
>
> This patch landed in yesterday's linux-next as commit ac8c259ce0d5
> ("exec: inherit HWCAPs from the parent process"). In my tests I found
> that it causes regression on my Khadas VIM3L board, which is based
> on Amlogic Meson SM1 (S905D3) SoC
> (arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts). Running init
> process fails after this patch:
>
> Freeing unused kernel memory: 13696K
> Run /sbin/init as init process
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x00000004
> CPU: 1 UID: 0 PID: 1 Comm: init Not tainted 7.0.0-rc4-next-20260319
> #12369 PREEMPT
> Hardware name: Khadas VIM3L (DT)
>
> What is probably important here, this board (for some internal,
> historical reasons) uses armv7l rootfs, but other boards used in my
> tests, based on different SoCs, also use such rootfs and boot fine with
> yesterday's linux-next. Reverting ac8c259ce0d5 commit (together with
> 0ea77bbf3b98 due to dependencies) on top of next-20260319 fixes this issu=
e.


Hi Marek.

Thank you for the report. I=E2=80=99ve sent a new version of this series he=
re:
https://patchew.org/linux/20260323175340.3361311-1-avagin@google.com/.
The reported issue should be fixed in this version. Could you please
give it a try?

Thanks,
Andrei
