Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB40413230
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922885; cv=pass; b=Lrxk69L9Xc+oniBpLN+EEd0vVOJ6LjlYyz80SiGqf6jXvKCHf48Hr91wJxlQt4azxsJfl7GSb8kzTV7Wk/2hOiXfoWf1rfy/FyhloAAHwvcqvs0zY+mAIb0QOVksXofdHMc52IH0dcRcFAbB1/3AWSmF3RVD9xuJ0jjAiSgagJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922885; c=relaxed/simple;
	bh=xxOvf721KgqJqT5Yjw9s9kJ3wImugFlnKAyCSgeC05M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UWqp0a8M0ikhTeP1rSRNudiMu5gnErv0VA9Kq8fxVgQvRwYKSDop2qBi5I+ic3wKQ+9JVgTLg2SDSvSdZrFjpcEGCi5FqhH9QPz/8Ihkv8pTOKlUQmRyW144ebvDqFKRt9TRdiwHNkhUfrMyyibf8MA6VKkYX55XDI0Xv3t9U74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npsiBw9k; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npsiBw9k"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5337fa12431so961771cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 13:21:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791922881; cv=none;
        d=google.com; s=arc-20260327;
        b=IKSsbarwRjyELoxg4jOH6Gn1dK9deUumPlwOiUYhVLU2Z3AirGqFPZ4krvrSHlOAsi
         9oZk3CpHxozUcfwSc26T4E3dH5PA6tzLeC6I52mtm7YyHtQM99i5RTbEZQVQH/+DKjl3
         bqNedCcVTjSUWNQGICMYS2Xpt4ZD7Bp19hZMo4yki4Qnzki6tY3kkEv3xpOgfxRr7OXG
         6IisADDZpCKfEhQSd07H8JLdQ0EcSabpqkGuOZ+4D/TYLzi7/dJ60osiwhpgNAdZy7ag
         uxAl+UGtoYSRQrPfjZiufFZiiN0TnB5xiA/fxSrr+4YryrM9cZwRQsOsOFvd+Hfw0qIe
         671w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Uu3Iqv0t79GTDrfZYBvAaVsbzV6bjgjtd2RimZpM59Y=;
        fh=ictBVideZx6NIah2c5wAzd1ItIsifHhDzhdnWtda6s8=;
        b=Tfst4EvggEy9+gt1KJRFz7N82KFbxt5/UGm8dYwFpkya2PI9liNvx2sUZwFH8i4yPE
         gCPrba0B/p+cjIMQtmo9FWyylxNUleYJHxW5ERaGgYngeGUETwnA/G03TApXViCIKlBI
         L8UprI2dzEa7RZ2BBu8Fw2FmYVA8UR2CXHf3CJYurhsvgZaREGYPk0hITGFMwwM2UBRS
         fdL28jcmPwCbFkw33cATNKTpWVjhGh/C+7vnit7GIe9TrvrjEZJJOie/OcFzdZ7V5Vs/
         VOnPBG1cQylazZRqaBQwPE+CcITbzZCAkHy0GL+d5L+uJLL6iVVyHtC2ooBjt1vS4ZP5
         FKzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791922881; x=1792527681; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uu3Iqv0t79GTDrfZYBvAaVsbzV6bjgjtd2RimZpM59Y=;
        b=npsiBw9k6H5bnEeipVCbpJqWsX/sV0UuP0Gu5rthcuO1eUgYFm208blNEcrdUUTz6v
         xB3qL9Cw2qFL/ygJsUHVeZmGCpoP2XWgOmyP/jz71AKqWZnIvm4ETE89LaTZN9wiOKEA
         XwAEk+rx/k+2RFIUAiiNvvxPqMCE5Hzc2hZikrP4GencDCsoyoJj3Fjx+XtXHLJORjOo
         N8+D2APBi8caXoxATB9/DNNrpxJiZE2XS/AUG2vfajMS/+Tr0yu7JeNtX8VkcZqabseq
         6h4R8goqgRXarjagdRa9g27qZ3LpedVOCd5Qt2fQ0dnnCoQAlImIVt812kxUf4ejNa/5
         TeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922881; x=1792527681;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Uu3Iqv0t79GTDrfZYBvAaVsbzV6bjgjtd2RimZpM59Y=;
        b=Bmn7y6QLQSUbGQaBC2MX1/EjmdE7wRz186miTey3cp4Fr5LEUBYTDyvoTT9hrbjNZb
         1LDEZymdWva6hfuCJBjihFWsAy6+1hQrs+HdsbcWDxIr9xInE1v+u3JFt1orvhTNcpz7
         xZxDXTYn5xdN+ZXVIY4jeLjQTiAc3RunDJ2gIs3VLY7MWivW9p6dRmr4MMxS56nSyiGj
         luq88sBFFGqAaq2D8doTcdmYN567CCWMe7x9hxWCVindOGhXxurYHPpdYF9zcyZcm8Cz
         KSTkuoVS4cz80OQ6UKRvJFifQ6lNzhnM94N4vRcbRiQ0CyT0proqUnxxikXpMDhMdQR7
         u03Q==
X-Forwarded-Encrypted: i=1; AKwUvBwT/ftqSOB5+CXWxTxWyiZgJKm659I3Z0ldyP7IITQOXiu7geyM2sgQKCRKws9c8O2JtkT7RrEf+uc6VAu+@vger.kernel.org
X-Gm-Message-State: AFq9FYKHlgoNS8u4LrX6HFK2dp79V10pbbDtuM8NWGnFR/Xqeq0H1FA4
	Za+xCouh8U85fDcmxO3sk0Bc6CJ+dWNTewgD3lGNfA3r6tWcWaPO5zqeS97N6wnFzpoXR1OknJV
	qn2y0NCiO4yHtC/VZvvCJIx7JcDajSFSeIcw/qe9t
X-Gm-Gg: AYBFou3aQGPugeNxZVYE7OgEwb2TxtF9PIDKkypGzOGcFMrEQAiQP+33kI0oxQ6yyf6
	RnJ8VyIzVrEsb9RxMbn56igh0H8TftjhmfFOdKB2v5BVSo5cCkOfxxFfkDn6rz62/P3noLThZUS
	4Y3LiA4JEfLMXhLkO++/H+X44U3kqKmaIqnboOvNmAkD8skv9iFWqHxpNu2WoJJXEB61bdknc3+
	n3ZMsX4rwZGAJAVhkODKFWZNIpyl2SvKnurjRSbfaomYrlPDUbWeeBHRSjoKK7dSIHb1QlJEJBz
	G7TgKgUABie04nI29coWtJh3QEY1BhB/3Ns2y4+1n9Hiz6JeTwH5dtH6w5c+4PjiFhuWxvQJ6px
	dNPzRu/9RJMa+yAqGz/Cw3GiY
X-Received: by 2002:a05:622a:1ba0:b0:534:313:9b4e with SMTP id
 d75a77b69052e-535b321298dmr57512211cf.5.1791922880608; Tue, 13 Oct 2026
 13:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sadrul Chowdhury <sadrul@google.com>
Date: Tue, 13 Oct 2026 16:21:08 -0400
X-Gm-Features: AclHuK9Vyag4IawcrZG5-4LpkcYucq7mjmH0zXviiwtdCJ8nVZ-d17BCJwjshGc
Message-ID: <CAKgcGXh-qG4LD70wSJMtfadXk+a9XaayfwtzGe3F0LbekYMOmw@mail.gmail.com>
Subject: [RESEND] Re: [PATCH 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	John Stultz <jstultz@google.com>
Content-Type: multipart/mixed; boundary="000000000000c552f3065dbe8eaa"

--000000000000c552f3065dbe8eaa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 8:21=E2=80=AFAM Sadrul Chowdhury <sadrul@google.com=
> wrote:
>
> On Wed, Sep 23, 2026 at 7:24=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 22-09-26 21:15:58, Sadrul Chowdhury wrote:
> > > During system suspend (freeze_processes) and resume (thaw_processes),
> > > threads blocked in epoll_wait() sleep in TASK_INTERRUPTIBLE. When
> > > try_to_freeze_tasks() executes, it must wake up every sleeping thread
> > > with a synthetic signal so the thread can schedule, run try_to_freeze=
(),
> > > enter TASK_FROZEN, and sleep again. Upon resume, the freezer wakes th=
em
> > > all up simultaneously, only for each thread to re-enter ep_poll(),
> > > observe no ready I/O events, and call schedule() to go back to sleep.
> > >
> > > On systems with numerous event-driven daemons (where hundreds of
> > > threads idle in event loops), this causes a large wakeup stampede and
> > > thousands of redundant context switches per suspend/resume cycle.
> > >
> > > An earlier attempt to make epoll_wait() freezable in commit 1c441e921=
201
> > > ("epoll: use freezable blocking call") was reverted in commit
> > > c511851de162 ("Revert "epoll: use freezable blocking call"") due to
> > > reports of userspace corruption (Bugzilla #61781). Under the legacy
> > > freezer design, freezable tasks could wake up prematurely while
> > > hardware and peripheral drivers were still suspended.
> > >
> > > With the 2022 core freezer rewrite (commit f5d39b020809 ("freezer,sch=
ed:
> > > Rewrite core freezer logic")), the legacy fake-signal mechanism was
> > > replaced with the TASK_FROZEN state. Tasks sleeping in TASK_FREEZABLE
> > > are safely frozen in-place without waking them up, and the scheduler
> > > guarantees they cannot be woken until thaw_processes() explicitly cle=
ars
> > > the frozen state.
> > >
> > > Mark sleeping tasks in ep_poll() as TASK_FREEZABLE. Benchmarks on an
> > > ARM64 test device demonstrate that combining this with freezable
> > > select/poll reduces thaw latency by 63% (from 20.64 ms down to 7.55 m=
s
> > > mean at fixed CPU frequency) and reduces context switches during
> > > freeze/thaw by 87%.
> > >
> > > Signed-off-by: Sadrul Chowdhury <sadrul@google.com>
> >
> > With similar caveat as on patch 2/2 feel free to add:
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> >
>
> Thank you for the review!
>
> Regards,
> Sadrul
>
> >                                                                 Honza
> >
> > > ---
> > >  fs/eventpoll.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > > index 6cbef8b4c2e0..35992f6457bf 100644
> > > --- a/fs/eventpoll.c
> > > +++ b/fs/eventpoll.c
> > > @@ -39,6 +39,7 @@
> > >  #include <linux/rculist.h>
> > >  #include <linux/capability.h>
> > >  #include <net/busy_poll.h>
> > > +#include <linux/freezer.h>
> > >
> > >  #include <trace/hooks/fs.h>
> > >
> > > @@ -1987,7 +1988,7 @@ static int ep_poll(struct eventpoll *ep, struct=
 epoll_event __user *events,
> > >                * the same lock on wakeup ep_poll_callback() side, so =
it
> > >                * is safe to avoid an explicit barrier.
> > >                */
> > > -             __set_current_state(TASK_INTERRUPTIBLE);
> > > +             __set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE=
);
> > >
> > >               /*
> > >                * Do the final check under the lock. ep_start/done_sca=
n()
> > > --
> > > 2.55.0.1082.g2b9226bbc0-goog
> > >
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR

--000000000000c552f3065dbe8eaa
Content-Type: application/x-patch; 
	name="0001-fs-epoll-mark-epoll_wait-tasks-TASK_FREEZABLE.patch"
Content-Disposition: attachment; 
	filename="0001-fs-epoll-mark-epoll_wait-tasks-TASK_FREEZABLE.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mv74e4k40>
X-Attachment-Id: f_mv74e4k40

RnJvbSA1Y2FiZTkyNzg0NTM1ZDhjZDVjYzlkNGI3NmQxODRmMzUzMzg0OGIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYWRydWwgQ2hvd2RodXJ5IDxzYWRydWxAZ29vZ2xlLmNvbT4K
RGF0ZTogVHVlLCAxMyBPY3QgMjAyNiAyMDowODozNCArMDAwMApTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBmcy9lcG9sbDogbWFyayBlcG9sbF93YWl0IHRhc2tzIFRBU0tfRlJFRVpBQkxFCgpEdXJpbmcg
c3lzdGVtIHN1c3BlbmQgKGZyZWV6ZV9wcm9jZXNzZXMpIGFuZCByZXN1bWUgKHRoYXdfcHJvY2Vz
c2VzKSwKdGhyZWFkcyBibG9ja2VkIGluIGVwb2xsX3dhaXQoKSBzbGVlcCBpbiBUQVNLX0lOVEVS
UlVQVElCTEUuIFdoZW4KdHJ5X3RvX2ZyZWV6ZV90YXNrcygpIGV4ZWN1dGVzLCBpdCBtdXN0IHdh
a2UgdXAgZXZlcnkgc2xlZXBpbmcgdGhyZWFkCndpdGggYSBzeW50aGV0aWMgc2lnbmFsIHNvIHRo
ZSB0aHJlYWQgY2FuIHNjaGVkdWxlLCBydW4gdHJ5X3RvX2ZyZWV6ZSgpLAplbnRlciBUQVNLX0ZS
T1pFTiwgYW5kIHNsZWVwIGFnYWluLiBVcG9uIHJlc3VtZSwgdGhlIGZyZWV6ZXIgd2FrZXMgdGhl
bQphbGwgdXAgc2ltdWx0YW5lb3VzbHksIG9ubHkgZm9yIGVhY2ggdGhyZWFkIHRvIHJlLWVudGVy
IGVwX3BvbGwoKSwKb2JzZXJ2ZSBubyByZWFkeSBJL08gZXZlbnRzLCBhbmQgY2FsbCBzY2hlZHVs
ZSgpIHRvIGdvIGJhY2sgdG8gc2xlZXAuCgpPbiBzeXN0ZW1zIHdpdGggbnVtZXJvdXMgZXZlbnQt
ZHJpdmVuIGRhZW1vbnMgKHdoZXJlIGh1bmRyZWRzIG9mCnRocmVhZHMgaWRsZSBpbiBldmVudCBs
b29wcyksIHRoaXMgY2F1c2VzIGEgbGFyZ2Ugd2FrZXVwIHN0YW1wZWRlIGFuZAp0aG91c2FuZHMg
b2YgcmVkdW5kYW50IGNvbnRleHQgc3dpdGNoZXMgcGVyIHN1c3BlbmQvcmVzdW1lIGN5Y2xlLgoK
QW4gZWFybGllciBhdHRlbXB0IHRvIG1ha2UgZXBvbGxfd2FpdCgpIGZyZWV6YWJsZSBpbiBjb21t
aXQgMWM0NDFlOTIxMjAxCigiZXBvbGw6IHVzZSBmcmVlemFibGUgYmxvY2tpbmcgY2FsbCIpIHdh
cyByZXZlcnRlZCBpbiBjb21taXQKYzUxMTg1MWRlMTYyICgiUmV2ZXJ0ICJlcG9sbDogdXNlIGZy
ZWV6YWJsZSBibG9ja2luZyBjYWxsIiIpIGR1ZSB0bwpyZXBvcnRzIG9mIHVzZXJzcGFjZSBjb3Jy
dXB0aW9uIChCdWd6aWxsYSAjNjE3ODEpLiBVbmRlciB0aGUgbGVnYWN5CmZyZWV6ZXIgZGVzaWdu
LCBmcmVlemFibGUgdGFza3MgY291bGQgd2FrZSB1cCBwcmVtYXR1cmVseSB3aGlsZQpoYXJkd2Fy
ZSBhbmQgcGVyaXBoZXJhbCBkcml2ZXJzIHdlcmUgc3RpbGwgc3VzcGVuZGVkLgoKV2l0aCB0aGUg
MjAyMiBjb3JlIGZyZWV6ZXIgcmV3cml0ZSAoY29tbWl0IGY1ZDM5YjAyMDgwOSAoImZyZWV6ZXIs
c2NoZWQ6ClJld3JpdGUgY29yZSBmcmVlemVyIGxvZ2ljIikpLCB0aGUgbGVnYWN5IGZha2Utc2ln
bmFsIG1lY2hhbmlzbSB3YXMKcmVwbGFjZWQgd2l0aCB0aGUgVEFTS19GUk9aRU4gc3RhdGUuIFRh
c2tzIHNsZWVwaW5nIGluIFRBU0tfRlJFRVpBQkxFCmFyZSBzYWZlbHkgZnJvemVuIGluLXBsYWNl
IHdpdGhvdXQgd2FraW5nIHRoZW0gdXAsIGFuZCB0aGUgc2NoZWR1bGVyCmd1YXJhbnRlZXMgdGhl
eSBjYW5ub3QgYmUgd29rZW4gdW50aWwgdGhhd19wcm9jZXNzZXMoKSBleHBsaWNpdGx5IGNsZWFy
cwp0aGUgZnJvemVuIHN0YXRlLgoKTWFyayBzbGVlcGluZyB0YXNrcyBpbiBlcF9wb2xsKCkgYXMg
VEFTS19GUkVFWkFCTEUuIEJlbmNobWFya3Mgb24gYW4KQVJNNjQgdGVzdCBkZXZpY2UgZGVtb25z
dHJhdGUgdGhhdCBjb21iaW5pbmcgdGhpcyB3aXRoIGZyZWV6YWJsZQpzZWxlY3QvcG9sbCByZWR1
Y2VzIHRoYXcgbGF0ZW5jeSBieSA2MyUgKGZyb20gMjAuNjQgbXMgZG93biB0byA3LjU1IG1zCm1l
YW4gYXQgZml4ZWQgQ1BVIGZyZXF1ZW5jeSkgYW5kIHJlZHVjZXMgY29udGV4dCBzd2l0Y2hlcyBk
dXJpbmcKZnJlZXplL3RoYXcgYnkgODclLgoKUmV2aWV3ZWQtYnk6IEphbiBLYXJhIDxqYWNrQHN1
c2UuY3o+ClNpZ25lZC1vZmYtYnk6IFNhZHJ1bCBDaG93ZGh1cnkgPHNhZHJ1bEBnb29nbGUuY29t
PgotLS0KIGZzL2V2ZW50cG9sbC5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9ldmVudHBvbGwuYyBiL2ZzL2V2
ZW50cG9sbC5jCmluZGV4IDZjYmVmOGI0YzJlMC4uMzU5OTJmNjQ1N2JmIDEwMDY0NAotLS0gYS9m
cy9ldmVudHBvbGwuYworKysgYi9mcy9ldmVudHBvbGwuYwpAQCAtMzksNiArMzksNyBAQAogI2lu
Y2x1ZGUgPGxpbnV4L3JjdWxpc3QuaD4KICNpbmNsdWRlIDxsaW51eC9jYXBhYmlsaXR5Lmg+CiAj
aW5jbHVkZSA8bmV0L2J1c3lfcG9sbC5oPgorI2luY2x1ZGUgPGxpbnV4L2ZyZWV6ZXIuaD4KIAog
I2luY2x1ZGUgPHRyYWNlL2hvb2tzL2ZzLmg+CiAKQEAgLTE5ODcsNyArMTk4OCw3IEBAIHN0YXRp
YyBpbnQgZXBfcG9sbChzdHJ1Y3QgZXZlbnRwb2xsICplcCwgc3RydWN0IGVwb2xsX2V2ZW50IF9f
dXNlciAqZXZlbnRzLAogCQkgKiB0aGUgc2FtZSBsb2NrIG9uIHdha2V1cCBlcF9wb2xsX2NhbGxi
YWNrKCkgc2lkZSwgc28gaXQKIAkJICogaXMgc2FmZSB0byBhdm9pZCBhbiBleHBsaWNpdCBiYXJy
aWVyLgogCQkgKi8KLQkJX19zZXRfY3VycmVudF9zdGF0ZShUQVNLX0lOVEVSUlVQVElCTEUpOwor
CQlfX3NldF9jdXJyZW50X3N0YXRlKFRBU0tfSU5URVJSVVBUSUJMRSB8IFRBU0tfRlJFRVpBQkxF
KTsKIAogCQkvKgogCQkgKiBEbyB0aGUgZmluYWwgY2hlY2sgdW5kZXIgdGhlIGxvY2suIGVwX3N0
YXJ0L2RvbmVfc2NhbigpCi0tIAoyLjU2LjAuMzg1LmdkM2FjYjkwZWY4LWdvb2cKCg==
--000000000000c552f3065dbe8eaa
Content-Type: application/x-patch; 
	name="0002-fs-select-mark-select-and-poll-tasks-TASK_FREEZABLE.patch"
Content-Disposition: attachment; 
	filename="0002-fs-select-mark-select-and-poll-tasks-TASK_FREEZABLE.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mv74e4le1>
X-Attachment-Id: f_mv74e4le1

RnJvbSAyM2IwOTNmMGY5ZjI2NmE4MGQzNjcyMjdhOGVmY2U5OTUzZDkwYTdjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYWRydWwgQ2hvd2RodXJ5IDxzYWRydWxAZ29vZ2xlLmNvbT4K
RGF0ZTogVHVlLCAxMyBPY3QgMjAyNiAyMDowODozNSArMDAwMApTdWJqZWN0OiBbUEFUQ0ggMi8y
XSBmcy9zZWxlY3Q6IG1hcmsgc2VsZWN0IGFuZCBwb2xsIHRhc2tzIFRBU0tfRlJFRVpBQkxFCgpT
aW1pbGFyIHRvIGVwb2xsX3dhaXQoKSwgdGhyZWFkcyBzbGVlcGluZyBpbiBkb19zZWxlY3QoKSBh
bmQgZG9fcG9sbCgpCnNsZWVwIGluIFRBU0tfSU5URVJSVVBUSUJMRSB2aWEgcG9sbF9zY2hlZHVs
ZV90aW1lb3V0KCkuIER1cmluZyBzeXN0ZW0Kc3VzcGVuZCBhbmQgcmVzdW1lLCB0aGVzZSB0aHJl
YWRzIGFyZSB3b2tlbiB1cCBieSB0aGUgZnJlZXplciBzb2xlbHkgdG8KdHJhbnNpdGlvbiB0byBU
QVNLX0ZST1pFTiwgYW5kIHdva2VuIGFnYWluIHVwb24gdGhhdyBvbmx5IHRvIHJlLWV2YWx1YXRl
CmZpbGUgZGVzY3JpcHRvcnMgd2l0aCBubyBwZW5kaW5nIGFjdGl2aXR5IGFuZCBzbGVlcCBhZ2Fp
bi4KCkEgcHJldmlvdXMgYXR0ZW1wdCB0byBtYWtlIHNlbGVjdCgpIGFuZCBwb2xsKCkgZnJlZXph
YmxlIGluIGNvbW1pdAo5NzQ1Y2RiMzZkYTggKCJzZWxlY3Q6IHVzZSBmcmVlemFibGUgYmxvY2tp
bmcgY2FsbCIpIHdhcyByZXZlcnRlZCBpbgpjb21taXQgNTk2MTJkMTg3OTEyICgiUmV2ZXJ0ICJz
ZWxlY3Q6IHVzZSBmcmVlemFibGUgYmxvY2tpbmcgY2FsbCIiKQphbG9uZ3NpZGUgdGhlIGVwb2xs
IHJldmVydCBkdWUgdG8gaXNzdWVzIGNhdXNlZCBieSB0aGUgbGVnYWN5IGZyZWV6ZXIKYXJjaGl0
ZWN0dXJlLgoKRm9sbG93aW5nIHRoZSBmcmVlemVyIG92ZXJoYXVsIGluIGNvbW1pdCBmNWQzOWIw
MjA4MDkgKCJmcmVlemVyLHNjaGVkOgpSZXdyaXRlIGNvcmUgZnJlZXplciBsb2dpYyIpLCB0YXNr
cyBpbiBUQVNLX0ZSRUVaQUJMRSBhcmUgc2FmZWx5IGZyb3plbgppbi1wbGFjZSBpbnRvIFRBU0tf
RlJPWkVOIHdpdGhvdXQgcnVubmluZyB1c2Vyc3BhY2UgY29kZSBvciBleHBlcmllbmNpbmcKcHJl
bWF0dXJlIHdha2V1cHMgYmVmb3JlIHJlc3VtZSBjb21wbGV0ZXMuCgpQYXNzIFRBU0tfRlJFRVpB
QkxFIHRvIHBvbGxfc2NoZWR1bGVfdGltZW91dCgpIGluIGRvX3NlbGVjdCgpIGFuZApkb19wb2xs
KCkgKFRBU0tfSU5URVJSVVBUSUJMRSB8IFRBU0tfRlJFRVpBQkxFKSBzbyB0aGF0IHBvbGxpbmcg
dGhyZWFkcwpyZW1haW4gYXNsZWVwIHVuZGlzdHVyYmVkIGFjcm9zcyBzdXNwZW5kL3Jlc3VtZSBj
eWNsZXMuCgpSZXZpZXdlZC1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KU2lnbmVkLW9mZi1i
eTogU2FkcnVsIENob3dkaHVyeSA8c2FkcnVsQGdvb2dsZS5jb20+Ci0tLQogZnMvc2VsZWN0LmMg
fCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZnMvc2VsZWN0LmMgYi9mcy9zZWxlY3QuYwppbmRleCA4OTQzZjIwZTgz
MDAuLjVjYmJlODYxMzViYyAxMDA2NDQKLS0tIGEvZnMvc2VsZWN0LmMKKysrIGIvZnMvc2VsZWN0
LmMKQEAgLTYwMSw3ICs2MDEsNyBAQCBzdGF0aWMgbm9pbmxpbmVfZm9yX3N0YWNrIGludCBkb19z
ZWxlY3QoaW50IG4sIGZkX3NldF9iaXRzICpmZHMsIHN0cnVjdCB0aW1lc3BlYwogCQkJdG8gPSAm
ZXhwaXJlOwogCQl9CiAKLQkJaWYgKCFwb2xsX3NjaGVkdWxlX3RpbWVvdXQoJnRhYmxlLCBUQVNL
X0lOVEVSUlVQVElCTEUsCisJCWlmICghcG9sbF9zY2hlZHVsZV90aW1lb3V0KCZ0YWJsZSwgVEFT
S19JTlRFUlJVUFRJQkxFIHwgVEFTS19GUkVFWkFCTEUsCiAJCQkJCSAgIHRvLCBzbGFjaykpCiAJ
CQl0aW1lZF9vdXQgPSAxOwogCX0KQEAgLTk2MSw3ICs5NjEsNyBAQCBzdGF0aWMgaW50IGRvX3Bv
bGwoc3RydWN0IHBvbGxfbGlzdCAqbGlzdCwgc3RydWN0IHBvbGxfd3F1ZXVlcyAqd2FpdCwKIAkJ
CXRvID0gJmV4cGlyZTsKIAkJfQogCi0JCWlmICghcG9sbF9zY2hlZHVsZV90aW1lb3V0KHdhaXQs
IFRBU0tfSU5URVJSVVBUSUJMRSwgdG8sIHNsYWNrKSkKKwkJaWYgKCFwb2xsX3NjaGVkdWxlX3Rp
bWVvdXQod2FpdCwgVEFTS19JTlRFUlJVUFRJQkxFIHwgVEFTS19GUkVFWkFCTEUsIHRvLCBzbGFj
aykpCiAJCQl0aW1lZF9vdXQgPSAxOwogCX0KIAlyZXR1cm4gY291bnQ7Ci0tIAoyLjU2LjAuMzg1
LmdkM2FjYjkwZWY4LWdvb2cKCg==
--000000000000c552f3065dbe8eaa--
