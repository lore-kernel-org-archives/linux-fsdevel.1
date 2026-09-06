Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80688309F08
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Sep 2026 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788719139; cv=none; b=Tr1pszEEYLAeFRFIKwxzg1sRArVwPKVvYKWB4vyYPX9tk9g9R/Yboks+3aNm5QlzGOa9UY7QAWmtwmRUwFchh6lpvo+johEb1I2v1rWCiouB0E4SBghRPd7WHubAkwDopsgiB9g6SaP+Vtp8/ncIx5bkJFVN9J1axrFQGZPzEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788719139; c=relaxed/simple;
	bh=qRDd5nMDfOstiR14Q1KrbXzbdSK5Suchl7DnrlwB7rA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NTJwXDE642sd3EfeGMlqovA7c2gG44gQ+S3rGQqlo+PYlSnf8VGrfjYPkETclwDkcWgKynt3mI0Eu0RdUT1mIHBWd5c+9D27TAJ1a6mZDVa5belSnlcxp93VMJi3nON1Fb1xvsS8w+0ZWSSDAMiH3CgjTV9+Kx1m6nuNeeziXH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=VaNUr0NV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="VaNUr0NV"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c20ce3c118aso549134566b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2026 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1788719136; x=1789323936; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c00mRaBkEZkiSicA+frkQDnmrR5yS2WY+aX7Yj263kQ=;
        b=VaNUr0NVTcej1YoKCl/GkxKy4Qh684OyseECG1CpS+jOLwTtFZLC0Z024Fofrigbmc
         Or3hyomKqHtvWN9kz4r/emWMWqT4Nd6SuzkaL/we2K+0j3NEN4pLzEChe6Gx4XVGdVkg
         CLRht7gorgCooWrqhhgBxKeK/fBvQqa0JTjPCFphk6cm/RfqC9cLS/3Zsq6rdi84A61r
         7PBNzl69jzwfDhmR9tbHI0cKjGuWwg3JwLh5bCrNtvK3aVxqjpF/cSKv+4RKw80SRFIz
         uQDGhO6WDappg5J7HkjyH5YvCVwYmHa71CKRtwRp6vulHhJ0A3B3vZD3l1MfKO8G4WmR
         Ov7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788719136; x=1789323936;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c00mRaBkEZkiSicA+frkQDnmrR5yS2WY+aX7Yj263kQ=;
        b=siXSg4CePDTd5LgYBYp1xjPl+OmaQPgYzwtRHtt+ajFhNsytYhmTotOjAY1AiKOhlM
         t9nZPCAWLqVDaZkRQMIup2KVGmXTEIXm/Xh4/+FoSWzpo1kMUXy5cIkrsgKMN6t9mcyn
         HaXWwLsss7V8wUTNe4QX3NLJqKDcFLDoaW6nalu6L+5N56FUbFKMXao96gsbJZbVE+4S
         vWGbPuP3zxd+QyRGZieOGkNDQR5NMEjHg8uJ10rDPtiHKzXbCzY7t7Tcy8pia5q64VNn
         5QyrIewebzmsHxO89XNrA8hTUCLO97hVxFGWbRYsC3M56pFnxGjGLkQRyiuyLF94y87K
         XAEA==
X-Forwarded-Encrypted: i=1; AKwUvBxlbYNf742vNQvznf8NXMVuiVfAlzjg3kpo56lj8SwFkO1Bh0mCfG7th7+oJGv1SvHaHRb9PkkQNt8YOYbZ@vger.kernel.org
X-Gm-Message-State: AFuF++mkKdhE9w4CGo3GNZEVjOtRZIBDB30PHl6vk8hoAsR8Bx+SSYDF
	TrdQHTcaGo2N95TnEFC9ABeGAJmPItUVtRpglQSdu/AwEMPPclu7eNAG2kBKIi7iqDQ=
X-Gm-Gg: AYBFou0VxPUqOcE3I+kbNn3/pwRWxez/Ady0TUjy0VEmijLujusMf5LkUp2t03RAaqv
	gj2+WDo2qbNYeyKi5Q5oC1PiedJIRE1tuzPQwjSW1DCqPIbZ8DOGxsWatsOUFRCA9B6FqQ6pUHQ
	QCfx87f+a3fUm3WktwEwdVlWt4q0ymkiE3LjjGzxNRS0VyjjnfBiMJR2OINngyx5VXcjZmXZ2bW
	jqKa+kSUnH7uEPqbAFN8IgSIUz0p3kOm4wzIxZD9p3VxRi7TypTlpPQMPMXtp71s9kmxx6O8ArI
	BM0WA9UoIFv8HRZK29HOSgn3Rtr3EAtQQRhGqixs0r2KjirzHZaKfZ4D0aS3EEF4Ovv83VbWoSk
	SaOOzAlW+DOWya/JAGGz6+4B6c0yB2KbzS2C8YDDd4uqxMqdH5e6WHOmjClL7PN3pExA3vZRKJt
	c0Gh8yvoQjycKgfQqK3WKMcEVS85KeD0tMhU2zJ2sNoxvGi+7e428eodMZC05TRabwWv1T8vCKS
	qVgAUF5a8LCDer2Gumy7f/R5J+F0NM7CwmZbIYi7b+jFJrV
X-Received: by 2002:a17:907:940f:b0:c25:f7dc:2d8 with SMTP id a640c23a62f3a-c25f7dc0935mr899006966b.25.1788719135562;
        Sun, 06 Sep 2026 11:25:35 -0700 (PDT)
Received: from smtpclient.apple (80.49.147.201.ipv4.supernova.orange.pl. [80.49.147.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4aa0b9sm363969166b.11.2026.09.06.11.25.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Sep 2026 11:25:34 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] nstree: check listing permission before taking a
 namespace reference
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <F8EF9799-CDCE-435F-97E2-13B6CC92EC6D@mainlining.org>
Date: Sun, 6 Sep 2026 20:25:22 +0200
Cc: brauner@kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0ABE170-488A-49CD-8A6C-4D9EB94A18A8@doyensec.com>
References: <F8EF9799-CDCE-435F-97E2-13B6CC92EC6D@mainlining.org>
To: Bradley Morgan <brads@mainlining.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

On Sep 6, 2026, at 13:52, Bradley Morgan <brads@mainlining.org> wrote:
>=20
> On 4 September 2026 15:28:05 BST, Norbert Szetei =
<norbert@doyensec.com>
> wrote:
>> legitimize_ns() takes a reference on the candidate namespace before
>> may_list_ns() has decided whether the caller may see it. The
>> __free(ns_put) cleanup on the denied path can drop the last reference =
to a
>> mount namespace while we still hold the rcu read lock, and =
put_mnt_ns()
>> may sleep there. This is the same problem commit 2ec2aff3c8e2 ("ns: =
make
>> sure reference are dropped outside of rcu lock") fixed for the =
put_user()
>> path. Neither ns_requested() nor may_list_ns() needs a reference, =
both
>> only look at the namespace type and at the caller's own namespaces, =
so do
>> the checks first and take the reference last.
>>=20
>=20
> Great catch!
>=20
>> Fixes: 76b6f5dfb3fd ("nstree: add listns()")
>> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>> ---
>> A reproducer is available on request.
>=20
> Please? Or a splat, or anything?

Sure, both reproducer and splat below.

The reproducer uses two thread pools, one repeatedly calls listns for
CLONE_NEWNS, the other spins up short-lived mount namespaces via
unshare(CLONE_NEWUSER | CLONE_NEWNS) and lets them die.

The tmpfs mount in the child is the part that makes it show up quickly.

Run as an ordinary user, no capabilities, no root. I reproduced it on=20
the latest mainline and also the latest ubuntu.

Reproducer:

#define _GNU_SOURCE
#include <errno.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mount.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <linux/types.h>

#ifndef __NR_listns
#define __NR_listns 470
#endif

struct ns_id_req {
	__u32 size;
	__u32 spare;
	__u64 ns_id;
	__u32 ns_type;
	__u32 spare2;
	__u64 user_ns_id;
};

#define NR_IDS 4096

static volatile int stop;
static unsigned long nr_list, nr_churn;

static void handler(int sig)
{
	(void)sig;
	stop =3D 1;
}

static long listns(struct ns_id_req *req, __u64 *ids, size_t nr)
{
	return syscall(__NR_listns, req, ids, nr, 0);
}

static void *walker(void *unused)
{
	struct ns_id_req req =3D {
		.size =3D sizeof(req),
		.ns_type =3D CLONE_NEWNS,
	};
	__u64 ids[NR_IDS];

	(void)unused;
	while (!stop) {
		listns(&req, ids, NR_IDS);
		__atomic_fetch_add(&nr_list, 1, __ATOMIC_RELAXED);
	}
	return NULL;
}

static void child(void)
{
	if (unshare(CLONE_NEWUSER | CLONE_NEWNS))
		_exit(1);
	mount("none", "/", NULL, MS_REC | MS_PRIVATE, NULL);
	mount("none", "/tmp", "tmpfs", 0, NULL);
	_exit(0);
}

static void *churner(void *unused)
{
	(void)unused;
	while (!stop) {
		pid_t pid =3D fork();

		if (pid =3D=3D 0)
			child();
		if (pid < 0) {
			usleep(1000);
			continue;
		}
		waitpid(pid, NULL, 0);
		__atomic_fetch_add(&nr_churn, 1, __ATOMIC_RELAXED);
	}
	return NULL;
}

int main(int argc, char **argv)
{
	int secs =3D argc > 1 ? atoi(argv[1]) : 60;
	int nr_walkers =3D argc > 2 ? atoi(argv[2]) : 6;
	int nr_churners =3D argc > 3 ? atoi(argv[3]) : 6;
	struct ns_id_req req =3D { .size =3D sizeof(req), .ns_type =3D =
CLONE_NEWNS };
	pthread_t th[64];
	__u64 ids[NR_IDS];
	int i, n =3D 0;
	long ret;

	if (nr_walkers + nr_churners > 64)
		return 1;

	ret =3D listns(&req, ids, NR_IDS);
	if (ret < 0) {
		perror("listns");
		return 1;
	}
	printf("uid %d sees %ld mount namespaces\n", getuid(), ret);

	signal(SIGALRM, handler);
	alarm(secs);

	for (i =3D 0; i < nr_walkers; i++)
		pthread_create(&th[n++], NULL, walker, NULL);
	for (i =3D 0; i < nr_churners; i++)
		pthread_create(&th[n++], NULL, churner, NULL);

	while (!stop)
		sleep(1);

	for (i =3D 0; i < n; i++)
		pthread_join(th[i], NULL);

	printf("listns=3D%lu unshare=3D%lu\n", nr_list, nr_churn);
	return 0;
}

Splat, on Ubuntu 7.0.0-30-generic (PREEMPT_DYNAMIC, no KASAN, no debug =
options):

[   24.499428] RIP: 0010:rcu_note_context_switch+0x238/0x2a0
[   24.499431] Code: 88 09 00 00 48 8d 93 88 09 00 00 48 39 d1 75 6a 48 =
23 47 20 74 4d 4c 89 e6 e8 64 f3 ff ff e9 46 fe ff ff 48 8d 3d b8 fe 99 =
02 <67> 48 0f b9 3a e9 02 fe ff ff 49 8b 7c 24 20 48 89 7d e0 e8 c0 1b
[   24.499433] RSP: 0018:ffffcfa383867830 EFLAGS: 00010002
[   24.499435] RAX: 0000000000000001 RBX: ffff8c33e1612ac0 RCX: =
0000000000000000
[   24.499436] RDX: 0000000000000000 RSI: ffffffffb6527c27 RDI: =
ffffffffb7ce0450
[   24.499437] RBP: ffffcfa383867850 R08: 0000000000000000 R09: =
0000000000000000
[   24.499438] R10: 0000000000000000 R11: 0000000000000000 R12: =
ffff8c33fbb34580
[   24.499439] R13: 0000000000000000 R14: 0000000000000000 R15: =
ffffcfa383867910
[   24.499441] FS:  00007eb8b11fa6c0(0000) GS:ffff8c34438ff000(0000) =
knlGS:0000000000000000
[   24.499442] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.499443] CR2: 00007eb8b11f1e48 CR3: 000000016656a001 CR4: =
0000000000f72ef0
[   24.499447] PKRU: 55555554
[   24.499448] Call Trace:
[   24.499450]  <TASK>
[   24.499452]  __schedule+0xcf/0x650
[   24.499456]  schedule+0x27/0x90
[   24.499458]  schedule_preempt_disabled+0x15/0x30
[   24.499460]  __mutex_lock.constprop.0+0x550/0xaf0
[   24.499461]  ? irqentry_exit+0x2e/0x6f0
[   24.499464]  ? irqentry_exit+0x2e/0x6f0
[   24.499466]  __mutex_lock_slowpath+0x13/0x20
[   24.499468]  mutex_lock+0x3b/0x50
[   24.499470]  exp_funnel_lock+0xb2/0x260
[   24.499472]  ? _raw_spin_unlock_irqrestore+0x11/0x60
[   24.499474]  ? ida_free+0x14e/0x160
[   24.499477]  synchronize_rcu_expedited+0xe7/0x220
[   24.499480]  namespace_unlock+0x26a/0x320
[   24.499484]  put_mnt_ns+0xd3/0x120
[   24.499486]  mntns_put+0xe/0x20
[   24.499488]  do_listns+0x13e/0x560
[   24.499491]  ? __do_sys_listns+0x126/0x2d0
[   24.499494]  __do_sys_listns+0x126/0x2d0
[   24.499496]  __x64_sys_listns+0x20/0x30
[   24.499498]  x64_sys_call+0x2366/0x2390
[   24.499501]  do_syscall_64+0x105/0x5a0
[   24.499503]  ? __audit_syscall_exit+0x36/0x120
[   24.499506]  ? security_capable+0x70/0x1e0
[   24.499510]  ? ns_capable_noaudit+0x34/0x60
[   24.499513]  ? mntns_put+0xe/0x20
[   24.499514]  ? do_listns+0x18a/0x560
[   24.499517]  ? __do_sys_listns+0x126/0x2d0
[   24.499520]  ? __audit_syscall_exit+0x36/0x120
[   24.499521]  ? arch_exit_to_user_mode_prepare.isra.0+0xd/0xe0
[   24.499524]  ? do_syscall_64+0x140/0x5a0
[   24.499525]  ? ns_capable_noaudit+0x34/0x60
[   24.499527]  ? mntns_put+0xe/0x20
[   24.499529]  ? do_listns+0x18a/0x560
[   24.499532]  ? __do_sys_listns+0x126/0x2d0
[   24.499534]  ? __audit_syscall_exit+0x36/0x120
[   24.499536]  ? arch_exit_to_user_mode_prepare.isra.0+0xd/0xe0
[   24.499538]  ? do_syscall_64+0x140/0x5a0
[   24.499540]  ? exc_page_fault+0x94/0x1e0
[   24.499541]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   24.499543] RIP: 0033:0x7eb8b3b34c8d
[   24.499545] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa =
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4b d1 0d 00 f7 d8 64 89 01 48
[   24.499547] RSP: 002b:00007eb8b11f1e18 EFLAGS: 00000202 ORIG_RAX: =
00000000000001d6
[   24.499555] RAX: ffffffffffffffda RBX: 00007eb8b11fa6c0 RCX: =
00007eb8b3b34c8d
[   24.499556] RDX: 0000000000001000 RSI: 00007eb8b11f1e80 RDI: =
00007eb8b11f1e60
[   24.499558] RBP: 00007eb8b11f1e40 R08: 0000000000000000 R09: =
0000000000000000
[   24.499559] R10: 0000000000000000 R11: 0000000000000202 R12: =
00007eb8b11fa6c0
[   24.499560] R13: 00007ffd3d46d640 R14: 00007eb8b11face4 R15: =
00007ffd3d46d747
[   24.499562]  </TASK>
[   24.499563] ---[ end trace 0000000000000000 ]---

>>=20
>> kernel/nstree.c | 10 ++--------
>> 1 file changed, 2 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/kernel/nstree.c b/kernel/nstree.c
>> index 6d12e5900ac0..831f279d174a 100644
>> --- a/kernel/nstree.c
>> +++ b/kernel/nstree.c
>> @@ -533,19 +533,13 @@ DEFINE_FREE(ns_put, struct ns_common *, if =
(!IS_ERR_OR_NULL(_T)) ns_put(_T))
>> static inline struct ns_common *__must_check legitimize_ns(const =
struct
>> klistns *kls,
>>    struct ns_common *candidate)
>> {
>> - struct ns_common *ns __free(ns_put) =3D NULL;
>> -
>> if (!ns_requested(kls, candidate))
>> return NULL;
>>=20
>> - ns =3D ns_get_unless_inactive(candidate);
>> - if (!ns)
>> - return NULL;
>> -
>> - if (!may_list_ns(kls, ns))
>> + if (!may_list_ns(kls, candidate))
>> return NULL;
>>=20
>> - return no_free_ptr(ns);
>> + return ns_get_unless_inactive(candidate);
>> }
>=20
> Fix LGTM,=20
>=20
> + CC akpm, he tends to look at fixes in kernel/, if brauner wants to =
merge this then that's ok :)

Thank you.

>> static ssize_t do_listns_userns(struct klistns *kls)
>>=20
>=20
> --- Thanks!
> =
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net=
/


