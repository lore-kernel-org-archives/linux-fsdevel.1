Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500051;
	b=s9s/IvziT1nSKjKqS340/B1RcVPhB4s7wY51meXyWAqZhz2MUoHuLXx6ZlGjYUqLiZrT
	 fpzCn0qiGzHkf49p3+byX3srazX5Ww6BcPcwy8NI5Z949xP+XXQtaUw706+E1bA0wpTIQ
	 tULnz5Mdlp1VWEn3WURYLlHAlAC0UYsx31XUurobclVdvgLHMyG3f4/Ou0sO1zJNlTQJO
	 ycDSHQGUMVSYbIThYCFcIYXhMIrec6xgZ42gkVK2aXtBDRBrw5Tbvga4oj5H8Qz9+pbXU
	 +tQPDsBZDAstzmQP1dlWMUTZz1tt7h5cpoIhYn0NngPMZcjbWhjkoAo5AzW2LRIoZnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Subject:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/SLHfkNsrCjSRx5Wz9p+DTV861mq73QFj5nkNZKg5lU=;
	b=4lEyRQ/IUiOMfxw6VRgYHtRwUCjiuNWmr3Ij6RTuxLh41b27nM2siQHdm95Rui0Xf2FV
	 DE4gbfyknfywU3FGnec0BhtQNFOhyOR2ilG+POUEWp4tdVLBgyRqJwmJk3MsWFyQAoEUi
	 67MWi4EWm6Ld/fKf+fCipx+iwQEJhs1lG3/3RTNwM8cXfGJmBLDkqM2fG9T78xx26DjfA
	 YhJUOb25NwEt0FMj1a3VrqDqN1cZWY8wvecce0/PqILBPiY8s9pJ8Ty5yFoa7X8WDkxgu
	 4oJKckHakV3CyoQvb+fMpuR2kHz2L/VGU5CfAvnIutnNHnKO7PTOEOg+MBA+/otxeeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1+Zpv7v;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0012D606A32C
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 06:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0012D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1+Zpv7v
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cde1479f76fso2453697a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 22:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795500050; x=1796104850; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/SLHfkNsrCjSRx5Wz9p+DTV861mq73QFj5nkNZKg5lU=;
        b=q1+Zpv7vRdLuNryjubIcK9p1C6hYtJyM8s4Ya+V8PgQONvpdTC7Ua853SGJTsIUcXQ
         M0pFVL8Do2Ry2wiXUj3cxeKtoqtmO0eJBjUj9twM08oj3aaj/1mWJSU3N4CXDAYxBpCK
         on+bdLfyiTexuyK1b6zmgwGoqKXFL4GeCN4DTr+jWK4djxI0BL1/DadGxeBp6DK7jASk
         tRKgLLfGrF8S9KN1UlG+krPmugZz0AWnplxbg1kncJbcJLBXntvKA8UjrUbEBTdBxIUf
         JruoLYhZMGVzT+PZrzx9sT1rk+fc369T12hC6PaBt2ez90GghipDT83vmsUcG8y9Od5P
         M7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500050; x=1796104850;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/SLHfkNsrCjSRx5Wz9p+DTV861mq73QFj5nkNZKg5lU=;
        b=is4NlESSNdBRSxtNPNJ/AHAxf3mKMw9ZRq6ERjQc2sg4t84LPl3ME3c1JEcKe3ixrX
         UfZjTKHCA9dCJQx3OOtNwawEW7piouBpx5E+UqaMDrW5AojO8eQh1Jnzz2ZteH/zDFL7
         zs4piY0ev1MFbHS9PP2ER5u62SwCk2OgEPItWC+5P0t704A0STQwBZk/GzhCh57dgjgD
         NaFeHdw432c7uVah6M7fsLg4PduBF0YUjaZTge54E5OU91qqbdA8/YsxeXUEKreVlAil
         ltqKrYrjvhA57aCfOhXD9DG1ciQnv/bus/65DdXTw2Djg/Yhy+d0VTt+4qkqmJyhADgt
         1ULQ==
X-Forwarded-Encrypted: i=1; AL+hErFbb/cJGbR3gUaT7BTx2CJUhkeipYXf0tgpgZDgSqzfHaI+ClIbSsaKPC7iFcV3FFuLA1Hl6VixqVD+wts9@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZexTT2YL+hf22E+biHPdA88qH6A5bFNYJALPnpfjrozGVbZwd
	hM5mFC2oA5UU9SOGhCYGLzVUwCYWZcmZHYb1wF1TxKnipMGH6E6xTnVH
X-Gm-Gg: AZFdTZfuPSXJ+r1PqJ3lCAaZTIJztHrosnzA+lJA427Vm790tzm+r2oKgSBCJUkZzcD
	ldOjVst0KInzkCswAFZyMsfnKBo1bczupv8WFzs2uokMdEUB5JC55bYu0AsuPtzwo5nSfF1bnyn
	eXIjmXkZxXtOt3gmT01kAHWpXXJoTQjd1anafIfgCe1Y5mepESjpTYZoaoNPSOjKIh57R2L2sXb
	7nE2skWuQqE9SJmsaKQySOAEQ3YkBfQ9XlobPOsigVX449pQfefCdrt7f5bCaqex9jjsuv7VPWK
	JsRdlIKomNbgWYp4nwihw8mEylXzkkwQbvnvOV4X3LvGqbVI+HT7xqPMmtXgLv+810Ke7+5unTa
	tkLFa4GblIZXYdVy8gqRDaOya2V6CHouO+EYpoD3r4pVPrYGqfiN31np7WVOrEGSVWpK9L6QHHh
	814Fsd1nkZan1cAMrdFaT4HeOHP1JDGQk1ex+SfH2fPGVC1B2sUYl4c0J//fwRfP5eYeGV3lmIV
	FYiEupBy5ICE9Yh+LbtL0vJgPRp20dvPgUj9qWld0dH+r0tqXoEPXXp8eUC8D42Zvp2r4YY5bad
	h4wU35qYLhAauXO3I9YXGmj6PiesiIhUKIYxKvSNxrSQNOwMLFEG6uQyImiakZgvICURaFML4iL
	RgAIjzzHXPj2ao8ahubQTp5ASGJ6MINsMDtU=
X-Received: by 2002:a05:6a21:780a:b0:3e2:8b64:2ca0 with SMTP id adf61e73a8af0-4014d35f1bamr11982201637.49.1795500050075;
        Mon, 23 Nov 2026 22:00:50 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d03adafsm6596544a12.23.2026.11.23.22.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 22:00:49 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 06:00:49 +0000
Message-Id: <DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "syzbot" <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com>,
 <akpm@linux-foundation.org>, <andrii@kernel.org>, <bpf@vger.kernel.org>,
 <brauner@kernel.org>, <daniel@iogearbox.net>, <jack@suse.cz>,
 <jmorris@namei.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
 <paul@paul-moore.com>, <penguin-kernel@I-love.SAKURA.ne.jp>,
 <serge@hallyn.com>, <syzkaller-bugs@googlegroups.com>,
 <takedakn@nttdata.co.jp>, <jhs@mojatatu.com>, <netdev@vger.kernel.org>,
 <tomoyo-users_en@lists.sourceforge.net>, <viro@zeniv.linux.org.uk>
Subject: net: act_gate bug. was: [syzbot] [tomoyo?] [mm?] INFO: rcu detected
 stall in security_file_ioctl (9)
In-Reply-To: <6b051681.58b41460.7037.0590.GAE@google.com>
References: <6b051681.58b41460.7037.0590.GAE@google.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 23, 2026 at 08:45 PM syzbot <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com> wrote:
> rcu: 	         hardirqs   softirqs   csw/system
> rcu: 	 number:     5264          0            0
> rcu: 	cputime:      138      52351           25   ==> 52490(ms)

It's not tomoyo, mm or bpf. Looks like act_gate.
Zero new softirqs in 52 sec, so one hrtimer_run_softirq() doesn't return.

> RBP: ffff88807ed35538 R08: ffffffff91be1bbf R09: 1ffffffff237c377
> R10: dffffc0000000000 R11: fffffbfff237c378 R12: ffff8880b8228600
> R13: ffffffff89fd0480 R14: ffff8880b8228600 R15: 1ffff1101704514a

The registers with lockdep struct sizes:

  reg       value             points to
  --------  ----------------  --------------------------------------
  R14       ffff8880b8228600  cpu_base
  R15 << 3  ffff8880b8228a50  clock_base[HRTIMER_BASE_TAI_SOFT].seq
  RBP       ffff88807ed35538  kmalloc-512 + 0x138, tcf_gate->hitimer

act_gate has the only soft hrtimer that can be on CLOCK_TAI.
bpf_timer_init() rejects that clock.

TCA_GATE_CYCLE_TIME is an unchecked u64. In gate_timer_func():

  n = div64_u64(ktime_sub_ns(now, base), cycle);
  close_time = ktime_add_ns(base, (n + 1) * cycle);

With base = 0 and cycle = U64_MAX, n is 0 and close_time is -1.
The timer restarts in the past and __hrtimer_run_queues() runs it again.
It's there since
commit a51c328df310 ("net: qos: introduce a gate control flow action").

Jamal,
taprio's INT_MAX limit doesn't fit. tdc uses cycle-time of 600 sec.
The diff saturates the sum instead.
Here is a potential fix:

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 711cf24..5422d60 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -45,8 +45,9 @@ static void gate_get_start_time(struct tcf_gate *gact,
 				const struct tcf_gate_params *param,
 				ktime_t *start)
 {
-	ktime_t now, base, cycle;
-	u64 n;
+	u64 cycle = param->tcfg_cycletime;
+	ktime_t now, base;
+	u64 rem;
 
 	base = ns_to_ktime(param->tcfg_basetime);
 	now = gate_get_time(gact);
@@ -56,10 +57,9 @@ static void gate_get_start_time(struct tcf_gate *gact,
 		return;
 	}
 
-	cycle = param->tcfg_cycletime;
-
-	n = div64_u64(ktime_sub_ns(now, base), cycle);
-	*start = ktime_add_ns(base, (n + 1) * cycle);
+	/* cycle is an unchecked u64, the sum must not wrap into the past */
+	div64_u64_rem(ktime_sub(now, base), cycle, &rem);
+	*start = ktime_add_safe(now, cycle - rem);
 }
 
 static void gate_start_timer(struct tcf_gate *gact, ktime_t start)
@@ -107,15 +107,8 @@ static enum hrtimer_restart gate_timer_func(struct hrtimer *timer)
 
 	now = gate_get_time(gact);
 
-	if (ktime_after(now, close_time)) {
-		ktime_t cycle, base;
-		u64 n;
-
-		cycle = p->tcfg_cycletime;
-		base = ns_to_ktime(p->tcfg_basetime);
-		n = div64_u64(ktime_sub_ns(now, base), cycle);
-		close_time = ktime_add_ns(base, (n + 1) * cycle);
-	}
+	if (ktime_after(now, close_time))
+		gate_get_start_time(gact, p, &close_time);
 
 	gact->next_entry = next;
 
