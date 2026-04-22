Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762826299
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876894; cv=pass; b=kZLg/ZFYryXVxXmgyLkEFARaYAy2imA81V7dpKzy8TT6k98aZt8ugYfjbH15NjRzDk0SADMHh2aeK54I9KlPAwESc6W56yCPtYkNfdx1Pq3uYYMsqZIsrrbLHW+WcWmJM+CrXEAsW+D5yUAVg4n27sSyJ2MS9VX7uJid7Fg5z88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876894; c=relaxed/simple;
	bh=SgqcuBGyR+7+bi3ahpSDl7uTRylh4y9UZvzoV6AGlNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwgUqcUFiCtAxPe7FbX9VVJANt76kNnGBKgUuySeJaD0xXh0ldf9V0BFzmVMFZZGemLUOZ87JAj3KUASgmSO2051cET5jrlD7tnmVoATrTiV8rS4FcDoGh2zwZj/gKff5yhYWgiuTT+UB30lKp2KXUcRdE2j6WglcE6Q0/LAdTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SoyLJ+e8; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SoyLJ+e8"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 63M2ccYH1290578
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 09:54:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=XL7dxIBCBmghfOLorBnezj5utuHcb+OpZeGlEb6KQks=; b=SoyLJ+e8d8Sj
	IHmIa+t6DLifMX8n6h95JxWeJ9HavCr6oLdygg3GNc22vophQ99m611FehwLQuvp
	c1phngAxbMOwKUOmrx0UX+QTV0PgLI0EvOPMI+Tl++jjU+5KeC4yZ6NGiwIBf/gN
	jPwwL4CCUCS2SRBDWC937F+LDGPaxbA0W23OBCGTcM0+s/0NQdaBhtMHN5EzE5pP
	QqBV4ryhqMRjLRf/43jf3KnnvSpQn2PRV+ZlIQ22MAh9Qr/4Be+ZMfpxdHCXdLcX
	Y2PuoX816Hdn/JwrvtWGdU4AknL065GOnirBliF12Q5x/Laz6JNHMleqGgc2kAXO
	QmK2K7Knlw==
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	by m0089730.ppops.net (PPS) with ESMTPS id 4dpep9xmt4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 09:54:51 -0700 (PDT)
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-66f103b3141so3614529a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 09:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776876890; cv=none;
        d=google.com; s=arc-20240605;
        b=SLXaV85aNkdt0dntqEEZR8gQ4IpxzTaoXThC3g8p6T23PYSv5GwZfeiC1aoA8Fo/3c
         NImfovMEYiarbqbdgZay50O1xUS/N9kkYB3MmoS8GVgwsca/6P9KiXlU+D0wxJ7udeH2
         ZAhl0rAj2at94MUo42UKTiuCMql89XSCTi/eADlmz9d94Eer7mK2LBn0EUU8cMDha2xA
         J1olwb4KHDFc7dgE4AvF+iJkt2Y8jQr7LUfFLvlXBqScMR8TCvlxJ0+3pFfpcnQqVr1k
         ZCGGwxpHOBbtgzUfJm8WmF7OSRnk0JsNFpNR7jRxSqkkZ4rrH8nJ0SKCVzcWVq62sj6k
         d2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=XL7dxIBCBmghfOLorBnezj5utuHcb+OpZeGlEb6KQks=;
        fh=OkFhvOQLTc4BYTpYnTNL9GGrukn6LhHqgPPqNEJLjYo=;
        b=Tily50z2VTKxDicDy9+PhTWzHXzkZnEetNLX7vW/i6+36NtQCcRPTcIUnCK3ds/03f
         uIp4r+XOqTrkjnZLUZCcy81CrvGXDjmY5EN+h1Gp83wuViUE/hrhWsDiR8nDARwl0avR
         GNKCD9RWN+5f32pW1Vm66c3w9HixXcpBoghEHl4Z/ZXkdzzidsUcq7mbXCQlBuDr8p3y
         WUrE8O1ayTfrSg8kONzY1jVhQBz1liS2uCmx2IZQDtnwGoqMR8j27V9xJ0vmsypqmqtI
         fboanCEKK1ytS4yn8PXhMWrK3HQi+2dddeKeUp+qiG9sWQPvpD2+WX0eV8QkMZlYuWZ2
         vTFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776876890; x=1777481690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XL7dxIBCBmghfOLorBnezj5utuHcb+OpZeGlEb6KQks=;
        b=DUrhjAfv/R7lmcuDwyTGYy8Sqj8FNI7itbx7PxXfjdAqtdEQChE8qus/Kemtj1Ea9J
         V3djz5WGD+Kjy6MGwRB+d/rZDK4NRrVzKPL84Y3uFXX+XrGA194xckG9ZYQ5sJ4iWZ+G
         VWy88K8inYL3btXyKXxDeMkU9csGw8iEkbMH0siqzhNdVV9SuWvtao/d78B3mDdO8LRQ
         1JIKrw84HDz9Fa/kObaCup8lZVfVx1T5Ou9I96jqoK2J0tsEMcYI7ykpFpjfNhpLkgfl
         Eyv0Ojn2fYRb5LH0+bjycgcjKVoph94xGQy5H1iRDKJFsM0WENBlUCMzqt7eZMwiKgJy
         YjgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zaB6w+H6jdDk6flB3mXiGLQW3kJls6mwvBLr2cPQ7ziYq+z7wlJws6NXzcoWm/3Q4AuMEI0s85rkO46sz@vger.kernel.org
X-Gm-Message-State: AOJu0YwSVD6xLyJ+iLBUI/0Z01F4JG30jLeLsNjbdvtGrxllWtJMvbIE
	DMjleHg2f1AOChN8k5IRr5A43uIenm1L4K40aMbQlwDevv8TM/hEnRsW0unSYkwFTi5ZmU9PZlg
	Z68z88Eh55zpCbjyhZyzhb18f00jeqSdkzK5HcytqQNDhm+eo/g0WkRgwQFtOfPqawyqGh0n+6W
	dN2/AtR0BVvZPdCydGDmbOX3mtizgij77EX+WRB9K6
X-Gm-Gg: AeBDiet1uN5C1g8FXLDjIMTjBUm3c+eRWhHxS9yZFZVGm3YH4hA8kVUX+6/YPLWX+7k
	WWwwhdgqLl5Ge5IiCnMKGGiZne5QAS7v27uB9vtUm4QqKBPaUrvEUBrMbGJh5blQor8axrryY48
	pmNjEZfMQ8QWUgFjeEwPLg3CYJDGZYrisKRUwDiBs/Pvm5aIyV6sv8DCn6fE12+WTgoSoM6JmgT
	xqVDtlR47+S5RSB
X-Received: by 2002:a05:6402:a0cd:b0:66d:d1b1:dddc with SMTP id 4fb4d7f45d1cf-672bfedd3bemr8904855a12.26.1776876889741;
        Wed, 22 Apr 2026 09:54:49 -0700 (PDT)
X-Received: by 2002:a05:6402:a0cd:b0:66d:d1b1:dddc with SMTP id
 4fb4d7f45d1cf-672bfedd3bemr8904842a12.26.1776876889293; Wed, 22 Apr 2026
 09:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
 <20260416194844.3874004-3-ibrahimjirdeh@meta.com> <bcodsu6plppnwotjuisi7kvwkftpennowemslxur33qhtmd4qp@wc536gzxu53m>
 <CAAwtZY6Bas3jLQZ_GDhbjj4pekjhT6kxAQ+5_35mzwk5_HUKhg@mail.gmail.com>
 <g2fx5drvoen4tkmnxe2mc44gihhtcwqhhvc7nbe4dbv6ay6idh@xc2zlk3s7q2g> <CAOQ4uxg7Mfk5Y1qV9YD1eifO-bJ3+miCm4-GLO=sBs9q-1mGNQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxg7Mfk5Y1qV9YD1eifO-bJ3+miCm4-GLO=sBs9q-1mGNQ@mail.gmail.com>
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Date: Wed, 22 Apr 2026 09:54:37 -0700
X-Gm-Features: AQROBzAniL0CBamVC6qrFrJY4R_z1wJwmEg_FJObwV7Enr23DmjoxnoNTe8h3oI
Message-ID: <CAAwtZY7T-x1ChoZ6vQQVFyON1wm-E-GR8Sy6qQyy6vEc51dejg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fanotify: introduce restartable permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, josef@toxicpanda.com, lesha@meta.com,
        linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: vXRnmirq2tkYc62BNtMYxtjreHk5iTm5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE2MSBTYWx0ZWRfX0pnPG81LI3k8
 kd2UnKQrFwKBC6f56vYsybVJ1ZP8zNxDPHeVfw61YWphrNeinZIyWwNpwZuI2TO+lNasCRBcfcw
 /aVGYr3+bqLpIO13Cx5F5/22+1iJGZPm7nosKkRGZvugi/x3Xi5UIM1rIDjdEX7V+d5za/bZthO
 Lq94Fl9dQ+xpeVxTRyKgk4ZO0WG41aoC0/rX4wciqDcpbh1QS4BEqgnWOjRYZ2buCl83yjQROyn
 SrwrbRw/b9QBG3BlTaYQkjfCXbABgY4MTwgOg+YTXXkmZ9xcxo5Qq1UalbiDxdkBYRHYAf5PVUz
 Af/yNOTrk1ulFCo1An07wX9yS+YEkjIEpaadvbj/pdBOTTDnDd7uhN0YZwjhgHCu9TkHw1il3Sr
 egPwn/MUK/o+HsglBsI17OOh0CYbPo1rrazEgheuD1nUJ2q67TaemHtDyeI56QyO1MlFBUBfzMA
 soCBpycJ1DmMdFOlYKQ==
X-Proofpoint-GUID: vXRnmirq2tkYc62BNtMYxtjreHk5iTm5
X-Authority-Analysis: v=2.4 cv=MIJQXsZl c=1 sm=1 tr=0 ts=69e8fd5b cx=c_pps
 a=CYpx6mtW7qE8U/l5VCnCPQ==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=pGLkceISAAAA:8 a=lqIGGN1ECXefpuZwFDkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01

On Wed, Apr 22, 2026 at 4:18=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Wed, Apr 22, 2026 at 12:36=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 22-04-26 03:22:32, Ibrahim Jirdeh wrote:
> > > On Mon, Apr 20, 2026 at 7:37=E2=80=AFAM Jan Kara <jack@suse.cz> wrote=
:
> > > > > +const struct file_operations fanotify_control_fops =3D {
> > > > > +     .show_fdinfo    =3D fanotify_show_fdinfo,
> > > > > +     .release        =3D fanotify_release,
> > > > > +     .unlocked_ioctl =3D fanotify_control_ioctl,
> > > > > +     .llseek         =3D noop_llseek,
> > > > > +};
> > > > > +
> > > > > +const struct file_operations fanotify_queue_fops =3D {
> > > > > +     .poll           =3D fanotify_poll,
> > > > > +     .read           =3D fanotify_read,
> > > > > +     .write          =3D fanotify_write,
> > > > > +     .release        =3D fanotify_queue_release,
> > > > > +     .unlocked_ioctl =3D fanotify_ioctl,
> > > > > +     .compat_ioctl   =3D compat_ptr_ioctl,
> > > > > +     .llseek         =3D noop_llseek,
> > > > > +};
> > > >
> > > > The new scheme with queue fd & control fd opens up an interesting n=
ew set
> > > > of races which needs a deeper thought I think. As it is currently
> > > > implemented for example if there's a task waiting for event on queu=
e fd, it
> > > > will never wake up if control fd is closed. Similar problem is ther=
e for
> > > > fanotify_poll(). So we need to carefully define how operations on q=
ueue fd
> > > > synchronize with operations on control fd and closing of it in part=
icular.
> > > > Besides dealing with the hung waits (which can be dealt with by jus=
t waking
> > > > the notification_waitq from fanotify_release()) we also need to dea=
l with
> > > > fanotify_read() moving events from notification list to access list=
. I'm a
> > > > bit unhappy with how ad hoc and fragile this looks but so far don't=
 have an
> > > > idea for a cleaner solution.
> > > >
> > >
> > > I wanted to ask a few more questions here about the race conditions y=
ou are
> > > outlining. Is it accurate that the main risk of races is primarily
> > > related to early control fd shutdown with this new two fd case, or ar=
e
> > > there other races to worry about?
> >
> > No, this is my main concern.
> >
> > > I added a few protections in this patch so far and wanted to check if
> > > there are outsanding risks:
> > > 1) Have queue fd also maintain a group reference as well
> >
> > Yes, this is good and takes care that the group is not freed. But it st=
ill
> > can be fully cleaned up even if you hold a reference.
> >
> > > 2) Check for control fd close (group->shutdown) in fanotify_read. I w=
ill also
> > > incorporate the wake up in fanotify_release you have suggested here.
> >
> > Yes, I've noticed that but that check is racy...
> >
> > > Regarding fanotify_read moving events from notification list to acces=
s list, do
> > > we need to allow pending events in fanotify_restart_pending_events
> > > after all to prevent potential hung waits stemming from race with shu=
tdown?
> >
> > Thinking about this some more... Won't it be easier if the queue fd hel=
d a
> > struct file reference of the control fd? That way the notification grou=
p
> > couldn't be shut down until queue fd is also closed. That will deal wit=
h
> > all the possible races, we don't even have to hold a notification group
> > reference. I don't think this behavior would be surprising to userspace=
 and
> > I don't see any other possible downsides either. Amir, any opinion?
> >
>
> hmm, that sounds pretty neat.
>
> queue_file->private_data =3D control_file;
> control_file->private_data =3D group;
>
> Makes sense to me.
>
> Please remove the group->shutdown check in read and any other
> safe race guards that were added.

Thanks, this should be much more straightforward. I will send over an updat=
ed
version containing this change to hold file reference and other fixes soon.
