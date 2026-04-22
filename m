Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D13C2787
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849835; cv=pass; b=Ixsj0GM7KiKYm0I9txpWmls+Hf1XL34e6iblKEuXoOZNGJCuOhm6TmWg0q5wAnCvrN0nlnP9FXRj7lIFVKtGx+YS5JFg6GEcGAVfQaLUvyz1ptZXaUQolmy6YHmnxI6aFWeUY5LDSgKhnAhQe1nGvp69UERGLfM1DlyZXWt00r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849835; c=relaxed/simple;
	bh=cQoHCKzYjcCiNteIHsJR+Z1nezlA4uLUs01FXJmiS4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJpaB1UDwB9f50ktCNV1e2VXnCszAfnXeMuoFXWbxDWTXpUKIY7SugVspjJJZHNrmSEML+XKFqQnUXmq17Jr74AP8L4Az7L8ir9qeNIRR01J72ApfAFu4aZO9KmRT9gJWpb88qhLZjsZ0lOea+Mb+0TXJgkN6d2DefMP7aafrWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YsZqWwix; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YsZqWwix"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M3QBJ51817883
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 02:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=rCdHKJtUH/6uNx95rmjdixd67FgMgcTnO9DVgp0yYKw=; b=YsZqWwixPqXp
	J7Tg7QAlDJMSw2IT09fe6Y65yftLRhRB/8332RtA7Ib6NR7hpNa7o93mzTMtnwew
	q18IlqsrWDV/g3gozJ2b6RBzemwc0e3fFKlgXcoikdxSGRVFyliH3c6ujaskeSFh
	kCtinS4UQAvVaoRshdXbq8jxKz7gqRRWswA4+IBaFJddMuxkVu9NowSuw5J5ZjYi
	rrIwdc2LJQsfVOCi3V7wIl/IP8E5GCUgesJeRBavkSGWDnwtdC1nrDGcx7KMmeqD
	/2TwlWo+7quCkeArj4RgCTPC5o+LwIP9qt2jAg7wK0fqMCewjRpNz1yUjfYSoLNA
	eXtGuKGK3g==
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepbm52m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 02:23:52 -0700 (PDT)
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8f5bce308dso475891166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 02:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776849831; cv=none;
        d=google.com; s=arc-20240605;
        b=NhZ9P4soUHGf97imhYae4Nkphhj9O/kJj341Q3B4pxGFFQ+vC5AfUBEmuB4K40CDs9
         OnsR62989SWWl4O7QwlNMnjgomEA1SEF2WfDEME0pNINrLktkcRR+PBNit2LQ+h+LKMt
         T8fBq6QVWztdjk0M9vKGIr4999LwLAjlwJL5mSPF1Q3/8XhFVXq4ElwtNREgk8cEnoe5
         UFb16vjrxSbeitnKyUhPiKl7xsIjW2UJGfDyEzXRjvD/7XAP7u0rzVP3S0EPrgGfngM4
         kV+UKUhwqUy4uh1JMd4PmItSkctTWlU8tmAnucyN3TUVDs/sU+phfuTc4VWsytYI+gMf
         HIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=rCdHKJtUH/6uNx95rmjdixd67FgMgcTnO9DVgp0yYKw=;
        fh=c1ptjNVnOxgdSSoxL/cMUQsyqVUZ1D1Iz9LyovwEkZQ=;
        b=Qu7vjYxqfocpxw3xQmMhmnL79m5UXhYHi4FE9uz/Rm9LmOM3HDjRzQImJGMnnGLNdn
         Ih5ccf09uH3zM2ssCHn6kQR+ZeGfZggOOsRx7QnsOuAQ/yToyO7ZnHO9XCi4CKTKRNfx
         gygMLzTNe0lZfgeOnKueK+6nUs4lWWyZCU9sDXDt/t+OeCi/O9aDmjvuNSKeWR6lk26Z
         WOtM5LAeIsbnNkzeTceD3H08zy7GrZ+IhTEDKj6iiO/sQ3QFJgJK2eUORHtV3XaycVAs
         KoIzsOcbHzjR9H9oh9eIzJm5WgeDMFTDeuaS8CBAyNWnXd1un7vZDDQJNHA8JNY+luOF
         2jQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776849831; x=1777454631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rCdHKJtUH/6uNx95rmjdixd67FgMgcTnO9DVgp0yYKw=;
        b=r1BaSZrGiHKQN6Lx9CELLRKjAtCWav3G+WUtS0c+lv0XZ89qwmvDhOfsxZp+CGccGx
         2VZwuR15Vord7QThCem0O+I+8VmxlmtJxsiz51v3Fu6qV7dFBm/8Q7v2DyOjkPAHFQe0
         SgSVhkgel7TWcLekazfZ4Dccvvsv/6cXM3lbdQY5ebtOoNNYnG3xDcJpM6wvLtEQBkk1
         pIQPrjZTHuK3OOsW+XvqPK4XCxJHG+qKuWsbGPTvGwpQ+dmeUGWcg2a8PE0N24NR927X
         TxzjQKKKeqIxpQK8abAvUjIHB+vEHRpkA2uI3MzJmF0R3mPNzBZwClGvb1vsO+FGYlBu
         wcxw==
X-Forwarded-Encrypted: i=1; AFNElJ8srtpUbpMsNpm2ERkCBmqPoV2UIGgtK9y34DCbvATKWftbwVJaPqcYkFaOvvzd0HcBskGUGZndq1WIPnXV@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCQ3/XQSCaIFXUzQpQVaQOH1atAlovCrudWvmxoUBOVeA1K4l
	rvAu1qJkVDQ/zLIaZBNhopmfKmUxU5Xu0H/m1JNlsb4jIHzUwS+oJ/9C/LyexIIZZMgCfB6TlHM
	u9HXC+WHSVXkcn+o94v5/0FYP7fq38/lvrlWtH22Wx4atmGtQ/V+mpofkUTB7lap+lXScql+pw3
	wKLHrOzzkkDlYNQN4RorI0+oRuTdGA+D2l5F52ANtzMLs25Ldz
X-Gm-Gg: AeBDiev3/iU8eAaeIqBpjsIgA9aevxFErZfTFVAgC5XUQZZtG/EeQ7HLtSmNrbM4PWG
	6hTpB2PWDS8rEtRH3vHxfHxiKPbG8cDlrM3iDYSEBzRKPjQCqfFziFCCuHkFzn5veYBu/Flranx
	2OgftyLgJb8IuPbDgu9yAeQpRcmI+9XAmNOceIoy+6HBANiuM60tBt0B5Yjw/FQAdIEpH4aTs/w
	oY39N5KyZR2koHE
X-Received: by 2002:a17:907:3e99:b0:b9d:1673:9994 with SMTP id a640c23a62f3a-ba41e4fd159mr1052445466b.39.1776849830824;
        Wed, 22 Apr 2026 02:23:50 -0700 (PDT)
X-Received: by 2002:a17:907:3e99:b0:b9d:1673:9994 with SMTP id
 a640c23a62f3a-ba41e4fd159mr1052443366b.39.1776849830233; Wed, 22 Apr 2026
 02:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
 <20260416194844.3874004-2-ibrahimjirdeh@meta.com> <CAOQ4uxg=z5im3rOw6JXrNY6-ynBEoj_tF=Fsiu81xqiCBRfOjQ@mail.gmail.com>
 <g5rw56zfcrt5zzimyskj7tcrmnc3q4mfpuxx5hy3wnup627kkk@fmvp76xxc2ca>
In-Reply-To: <g5rw56zfcrt5zzimyskj7tcrmnc3q4mfpuxx5hy3wnup627kkk@fmvp76xxc2ca>
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Date: Wed, 22 Apr 2026 02:23:38 -0700
X-Gm-Features: AQROBzAXbZPIpFrmpd9_1tx1mAv_hatdOUcbh-mJvkYQt7NBjt-DJ6nomWAet-o
Message-ID: <CAAwtZY55zVVqQDe1bdPpD1A5fa_mLOWzm0VPHha2b6KAXDq_Hg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fanotify: add restart infrastructure for pending
 permission events
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, josef@toxicpanda.com, lesha@meta.com,
        linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: WWn7Fdlj_NmkBUcOkrydBTraRIGQXAXi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA4OSBTYWx0ZWRfXxDmNGipiWaxE
 4ocRzj8cQ2vuwmSv8tyk6YSRhVMxdfvYGZeefSutmbEDYD46xXsSs519nDTQZ/qgfl1z7iLFn5Y
 mDxfSvmMDC7HVFYajhh3hJohRolFkLRHKlhAEmtUaFAm6vZGeUjPbn5JnSmU7eQ+LFg3litDoxL
 S9r8tL3gBFHt5fLkrFOdujofiVLHUMSrUauKcWMM4vJqZxkpu7GybCyIiRjgIWwGn9QIuImtGwL
 Ci4oyG4WgtVkT64uBIuH57LZcr0VqrEwLLI7gaOmuXrqjG6+Sd65p7ZX62ATrM5DUQGvrI6J/KU
 CdtOBDHZgcRQw9BcV76rG4LWfGB1QzxLrr+LLYrzxJ2d96VIy3VepnEP7x/rQWDmv3QPE2s1a95
 5cBXW/00k1V8UAA4h+eXdmqpqCb6fBec4BfLeltLrvReAQqhZxqfBeVHfQs8y8AtbfJGB/Sq40x
 h9Q7Lc8jxVrLdxEhp2Q==
X-Proofpoint-ORIG-GUID: WWn7Fdlj_NmkBUcOkrydBTraRIGQXAXi
X-Authority-Analysis: v=2.4 cv=ap6CzyZV c=1 sm=1 tr=0 ts=69e893a8 cx=c_pps
 a=D+UBI74RbQA8i2EYnbuvxw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=-RQnKF-ij6X3QrI-krYA:9 a=QEXdDO2ut3YA:10
 a=PsfoTyiJ_72bb7xyA04f:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01

On Mon, Apr 20, 2026 at 7:37=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 17-04-26 13:09:59, Amir Goldstein wrote:
> > On Thu, Apr 16, 2026 at 9:49=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@m=
eta.com> wrote:
> > >
> > > Add fanotify_restart_pending_events() helper that walks the
> > > access_list and reinserts each pending permission event back into
> > > the notification queue for reprocessing. Events are reinserted at
> > > the head of the notification queue without merge or overflow handling=
.
> > >
> > > Suggested-by: Jan Kara <jack@suse.cz>
> > > Link: https://lore.kernel.org/linux-fsdevel/sx5g7pmkchjqucfbzi77xh7wx=
4wua5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn/
> > > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> > > ---
> > >  fs/notify/fanotify/fanotify_user.c | 30 ++++++++++++++++++++++++++++=
++
> > >  1 file changed, 30 insertions(+)
> > >
> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/=
fanotify_user.c
> > > index d0b9b984002f..787e57a00466 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -1095,6 +1095,36 @@ static ssize_t fanotify_write(struct file *fil=
e, const char __user *buf, size_t
> > >         return count;
> > >  }
> > >
> > > +/*
> > > + * Reinsert pending permission events at the head of the notificatio=
n
> > > + * queue for reprocessing. No merge or overflow handling.
> > > + */
> > > +static void fanotify_restart_pending_events(struct fsnotify_group *g=
roup)
> > > +{
> > > +       spin_lock(&group->notification_lock);
> > > +       while (!list_empty(&group->fanotify_data.access_list)) {
> > > +               struct fanotify_perm_event *event;
> > > +
> > > +               event =3D list_first_entry(&group->fanotify_data.acce=
ss_list,
> > > +                                        struct fanotify_perm_event,
> > > +                                        fae.fse.list);
> > > +               list_del_init(&event->fae.fse.list);
> > > +
> > > +               if (group->shutdown) {
> > > +                       /* Group is being shut down. Reply ALLOW for =
the event. */
> > > +                       finish_permission_event(group, event, FAN_ALL=
OW, NULL);
> > > +                       spin_lock(&group->notification_lock);
> >
> > This looks very awkward.
> >
> > We are holding the notification lock for the non-shutdown case
> > throughout moving the events back into the notification_list
> > (could possibly do that with list_move() if we keep a count
> > of in-progress events).
> >
> > Seems more reasonable to also finish all events in a single batch
> > if the group is shutdown and then maybe use the same helper in
> > fanotify_release().
> >
> > But Ibrahim, please wait for Jan's input on this before sending v4.
> >
> > There are many ways to do this, and reusing the existing
> > finish_permission_event() locking semantics in this loop may be
> > fine for simplicity.
> >
> > It is also a matter of taste, so please wait for Jan to chime in.
>
> So I wouldn't overcomplicate and just go for something like:
>
>         spin_lock(&group->notification_lock);
>         /* Group is exiting, fanotify_release() will remove pending event=
s */
>         if (group->shutdown) {
>                 spin_unlock(&group->notification_lock);
>                 return;
>         }
>         group->q_len +=3D list_count_nodes(&group->fanotify_data.access_l=
ist);
>         list_splice_init(&group->fanotify_data.access_list,
>                          &group->notification_list);
>         spin_unlock(&group->notification_lock);
>

Thanks this is much simpler. I will update it.
