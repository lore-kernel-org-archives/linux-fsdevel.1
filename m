Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C5D371887;
	Mon, 12 Oct 2026 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791769387; cv=none; b=WN92DhVkU8bB9RFa2aGRlUqPLvv0WQ31scvG+M73p7pUf8aoJtgJFXriVLlFhWiQZIk8/Bt4K9nRZeter4J37kahg2pIZkYJETRHTgxj+ESaA2mz4D2L4ZHCRYnOPIWgYk+vl44t3FtqZBDKkONRp0Z/NRIRb+ISZf6RLhjaHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791769387; c=relaxed/simple;
	bh=uOO8yUPcbHO2t16nwX57yyO34At8x/V6BNcoRxJ9Ths=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPy/L9cAleLpKFkcyVhLHWJL+WL9lYf7S3pvhEAodc3VONosFXXOxROuE3saOeaGDqAdCgV94s3mKiaBWwwtSOk0GgjclkoW/ceaoEpJ+HINj5vHDisAFuAZMzMJZNhlwiLoAynSs+B3KZ65kmeB4arSQ3O4q2O884X9ZCKjgA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=rDrn1jLv reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="rDrn1jLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=UeHWFTee2
	L5pNatr2v8jD8hfo9aA7PdEVYM1CZ+poog=; b=rDrn1jLvgtC6EH9pmSTPKgnmu
	ZwQxPxiCi+m2tVLZT1eQseB5+QaPEwegGq5p8RKS1Kr2Z+TmuvaSiT2sR3lJa0uH
	YGQWsgGVW3ALZyi3TCvLiuLID+WMsgmI98euNiWlRaGDvBrpqoT7oAljBL3PnycH
	BNmLpZf/T2U9lmE9I0=
Received: from [10.101.142.107] (unknown [218.19.14.194])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPSA id BbQMCkA2PwIWO8xq4DiCAA--.24847S3;
	Mon, 12 Oct 2026 09:42:48 +0800 (CST)
Message-ID: <437297ff-1bb4-49a7-a979-abccdd1814f8@stu.xidian.edu.cn>
Date: Mon, 12 Oct 2026 09:42:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync
 signaling
To: Oleg Nesterov <oleg@redhat.com>, w15303746062@163.com,
 David Laight <david.laight.linux@gmail.com>
Cc: jlayton@kernel.org, chuck.lever@oracle.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, alex.aring@gmail.com, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d15a25fe784b5d4449c7ce4e56f1428d7ff28885.camel@kernel.org>
 <20260523135210.590928-1-w15303746062@163.com> <asI5Fn87_SoEd4G5@redhat.com>
 <asuxzwl4iWjjEjRD@redhat.com>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <asuxzwl4iWjjEjRD@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BbQMCkA2PwIWO8xq4DiCAA--.24847S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw17Ar4rury8Zw13CF1rWFg_yoWrAFykpa
	yYy3sxAr1vvFyjva9rtF48uayrZan7JrW3WFWfG34Fqay5ZryUXFyxXFyruFW5Wr4v9F9I
	qFn8XrWxWF1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9lb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUg0D2UUUUU
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUEEWrLplBHIgABsi


Hi Oleg,

Sorry for the delayed response due to the recent holiday break.

> Mingyu, could you provide more details? How was this problem reported?

The warning was found during kernel fuzzing with DevGen, our own testing
tool, in a QEMU x86_64 guest. The report identifies the kernel as
7.0.0 #6, PREEMPT(full).

This was a lockdep report. It does not establish the actual deadlock
interleaving described in my changelog, nor does it substantiate the
claim about a remote denial of service through TCP URG packets.

> but queued_read_lock_slowpath() does not block the reader if
> in_interrupt() == T ?

You are right. My two CPU scenario overlooked that an interrupt reader
can acquire the read lock while the writer is only waiting.

I also agree with your concern about change_pid(PIDTYPE_PGID). RCU
protects the task lifetime, but it does not prevent the traversal from
following a node into another hlist after that node is moved. My
justification for replacing tasklist_lock with RCU was incorrect.

In the original report, the task triggering the warning was in process
context, through a TTY ioctl. Here are the relevant excerpts; omissions
are marked with [...].

WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
7.0.0 #6 Tainted: G W N

syz.2.658/3606 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffffffff8760c098 (tasklist_lock){.+.+}-{3:3}, at: send_sigio+0xc0/0x380 
fs/fcntl.c:932

and this task is already holding:
ffff888105547220 (&f_owner->lock){....}-{3:3}, at: send_sigio+0x36/0x380 
fs/fcntl.c:918

which would create a new lock dependency:
(&f_owner->lock){....}-{3:3} -> (tasklist_lock){.+.+}-{3:3}

[...]

Chain exists of:
&dev->event_lock --> &f_owner->lock --> tasklist_lock

[...]

CPU: 3 UID: 0 PID: 3606 Comm: syz.2.658 Tainted: G W N 7.0.0 #6 
PREEMPT(full)

Call Trace:
<TASK>
[...]
send_sigio+0xc0/0x380 fs/fcntl.c:932
kill_fasync_rcu fs/fcntl.c:1144 [inline]
kill_fasync fs/fcntl.c:1159 [inline]
kill_fasync+0x21d/0x520 fs/fcntl.c:1152
__receive_buf drivers/tty/n_tty.c:1632 [inline]
n_tty_receive_buf_common+0x670/0x1770 drivers/tty/n_tty.c:1715
tty_ldisc_receive_buf+0xa8/0x1c0 drivers/tty/tty_buffer.c:387
paste_selection+0x605/0x730 drivers/tty/vt/selection.c:439
tioclinux+0x3d3/0x630 drivers/tty/vt/vt.c:3505
vt_ioctl+0x23ec/0x2ee0 drivers/tty/vt/vt_ioctl.c:753
tty_ioctl+0x717/0x1670 drivers/tty/tty_io.c:2792
[...]
entry_SYSCALL_64_after_hwframe+0x77/0x7f
[...]
</TASK>

The report separately records the following lock usage history. These
are historical acquisition paths, not simultaneous CPU stacks showing
a confirmed deadlock.

... which became SOFTIRQ-irq-safe at:
[...]
input_inject_event+0xa4/0x3b0 drivers/input/input.c:419
__led_set_brightness drivers/leds/led-core.c:52 [inline]
led_set_brightness_nopm drivers/leds/led-core.c:335 [inline]
led_set_brightness_nosleep drivers/leds/led-core.c:369 [inline]
led_set_brightness+0x21c/0x2a0 drivers/leds/led-core.c:328
led_trigger_event drivers/leds/led-triggers.c:420 [inline]
led_trigger_event+0xdf/0x270 drivers/leds/led-triggers.c:408
kbd_propagate_led_state drivers/tty/vt/keyboard.c:1065 [inline]
kbd_bh+0x23c/0x310 drivers/tty/vt/keyboard.c:1244
tasklet_action_common+0x25c/0x3d0 kernel/softirq.c:925
handle_softirqs+0x1ba/0x890 kernel/softirq.c:622
[...]

... which became SOFTIRQ-irq-unsafe at:
[...]
__do_wait+0xfe/0x870 kernel/exit.c:1678
do_wait+0x1d0/0x5a0 kernel/exit.c:1722
kernel_wait+0xa4/0x160 kernel/exit.c:1898
[...]

The recent program history includes id=658, which contains:

ioctl$TIOCL_PASTESEL(r1, 0x541c, &(0x7f00000000c0))

This is consistent with the reporting stack, but the program history
should not be treated as a validated minimal reproducer.

I support reverting the RCU replacement. I am sharing these excerpts
to clarify how the warning was reported and to help assess the original
warning and determine the appropriate next steps.

Thank you for pointing out these issues.

Mingyu


