Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.143
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536729;
	b=RZGD7Vc88NHO6/Hl/WAFf3mpF6adJauPxz0JYvwTZZuuCKwhyHp/qfFQk47uGQhZlnDg
	 ua/sQn3yWUSgNmOLmhSOZsZRMjZES+f09/PrpvNNeJU+VATz9AbUl+QxcqXVaO9fiL+7V
	 ZLqZKv/uzBZ+tUteYerYdOwEq2VAO2HIZX4+yDrrSdjmKeuczk+cCFYky9AVhzdLkNleH
	 aMcgJjlHZbSfSJVdzQTB7mpIZ/5qEjkKPay02Hwip7nF2aGdzLDzUHbQ/d+w1d2Y1wh+H
	 2OyVDawyvbp0MvSYShpuH3AOmWVzZGK1xWNvuoE/5GclspIYBxABkyPKuYNtSZd5Qzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536729;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	bh=kavqrmLGpGeX5X8Sqs6AVTpgYP3MA4DA32ch48L36nM=;
	b=La3alCUEKbPvLd/G66UQkJa7hOJTcVmDhpcMRkuxEXF9d+Kc/iJT99rfItqkWJdwA/fL
	 9NTvZLSLNlyeF3xZEijhSODQIrrTjDek0q11ZLHwkUrLBEjKYI38EEEHnbbO3xdepL1Ke
	 Z2PMBecNqk8YANGlClPJa1lX3io9YBbi7BeqwZjLR570qfGW2ABzmAnQWR8x9hGNQioKl
	 pOTfgg8k9qIeub8a9z62CQ6u6/WLv0EMpW/RiJ39mTXOrjc+y7R6d7Zauf+wQfR+yiicc
	 p/Qm8DyYHv05UZVEO9Lnjay4+qVYdSRXM2OjEtDZl8qe+IaC3hm+81W6xBQHtyc+07A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=greenberg.science;
	spf=pass smtp.mailfrom=greenberg.science;
	dkim=pass header.d=greenberg.science header.i=@greenberg.science header.a=rsa-sha256 header.s=fm1 header.b=XlMbiapV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="57m/pOiU";
	arc=none smtp.remote-ip=103.168.172.143
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF9606A329
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 16:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22BF9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=greenberg.science
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=greenberg.science
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=greenberg.science header.i=@greenberg.science header.a=rsa-sha256 header.s=fm1 header.b=XlMbiapV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=57m/pOiU
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 38170138066A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:12:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 24 Nov 2026 11:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	greenberg.science; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1795536727;
	 x=1795543927; bh=kavqrmLGpGeX5X8Sqs6AVTpgYP3MA4DA32ch48L36nM=; b=
	XlMbiapVtK2MvOjvpfTgRzNa65x/mx7K/Q5vMnw/YO/Wphs/iVTVar+QY1sjBGTH
	sPBxK3zZQc1GJ3nOr58mjkNJ3x+KYWbyJoEMimANKBviNNbR5/irVD1YE1G2FYWL
	v03odM0lNaIMa727EaZcEbV82tR9ergoqxYNFzb17FmWVd5wkMQlBYWqiFvCPKjI
	RBvwDx27VNkB+fuObNMwD81p02mAkWbNGmtXJBsNNEhJWEPTW1+PhFcEju6cT/bg
	aJA/kJY1fd9t9A8H9FTmMpuLfyA5Hw9tKr+rw2pXu+RhdrFtxxjljsOks/gcbsdF
	WIf94C8iL/6qLGGSfnaQlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795536727; x=1795543927; bh=kavqrmLGpGeX5X8Sqs6AVTpgYP3MA4DA32c
	h48L36nM=; b=57m/pOiUMBINck0za1OGBmzj1cqm9IwloTprXh7S9XhBWpoFzx/
	hmup6F8dIJlFkSPin5/39oJNxdA0deb7wV9Bbp9wbaYnVHnj5L4bUAj2jnzBPNnP
	tR3Dha9Rbxufgnbwe2zjN55yvAwXgxS9PcmylYQ32aVFXpIF54MWR57fVPahrfff
	pcodInDJJO9ZqiAqJ+f4RRObHBZPdtRWrh5GajJSXtDOKAXkOyoqxxrZk5A1ZGqr
	Tpv7QteycXQjWr7nc73hDFPRu7pLJjwlGqgzLBR3mhAKrspjpCDs+Hcp7sbD8kFY
	EICxJoYpdeBGzCl85QtSS7le57cuT1u8pVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=greenberg.science a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795536727; d=greenberg.science;
	mf=PG1pY2hhZWxAZ3JlZW5iZXJnLnNjaWVuY2U+;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:rXanIOhamPfoFCHqfH5MdG3pRWLXp1fLSwN7zv0yDXpVTvV
	kASm7V9WyMNEmsvMXRSfrNNCmKCBO5bp0E3n+aaasSvLVbtHoN74joS5+3T+wCyo
	ll2IkysyosHl2Kn7FQk7/rQ82r5TzxIImc62pCcNDBMbaGVHzmR+25mMHLnUvF3q
	3vfZj8E5lx/QFNF+2Goa2uaRoDcmfeV/sCxUAc5Di+sy4t+gOE4sim+gqtw9tlqh
	IPFqwQWjfoi3J9w2cudZCyPWKAGNoQhba+49w2n5v8sqQWZuhRAojB0YLb3uuHCr
	8UAPI23kqT2i+gcn/f3kZGSR/Heg3fhcVw607zQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rYbzNi02L9qoh9AqsFS3Qr2IwWk8GUbcnLCBpTav1lw=:w6J9vuYaGxv5oMVq7U8acYcy5eP42DqkqZlvpLPG0to=;
X-ME-Sender: <xms:V7cFa4Uj-VYjVOXlUKTuSSmZkcDSN4o2x1RmxNxiGW6WnLS6cnqY6Q>
    <xme:V7cFa4DrL0G_LCHRzOceEkuotZkr2zX03J2Q4y7ssVw9YDocncAAJeHVh1vQ7TOAI
    w0sx0XrHr2qClBvQd7gHcCabBraHx4icjN6CubVwEvU6s9tmQsuPV9nlQ>
X-ME-Received: <xmr:V7cFa_5Y53Dy7ND9_PEJM4Tt8HRpCFRGO2LxP_DpntzRa2hRUIY_EwYrhNp6>
X-ME-Proxy-Cause: dmFkZTGAfQ8ijDtb/R2UaPaetkQfL2SGYdcvA7GlIGbKGJOYHZHffVuQyryaM9svOCDuw3
    8RqwCdml00Y3nR85ll87A4YQ/yOxrjtZYlYSnGr2IGUEd6LXSaSneyUKHD48wbTN7ajg4R
    5j7TepRbA90Ay4N9NFBwL4bBZ6voYx5VMrJMmPTg90lILN/OxEK/y5KzSBmqGpaGDiEXMu
    uWfYbeJJMCAO3Ykhm6ZpLSafZ8LzGMmOEQEGKqvJaDrUijiFF81+tss4ONRZhPOPLNnfkW
    bccLEkaOrJjwtSbYjNOGo50BB8n9+nf4jqNynEfus1EKmDp2nrMstvnKMoKQ09IQgnejg6
    L4kl78swiqoznABsW1phrZ4YSiv1ER/DWfC4ADrj/U9AKqPgws0FmcAweEKHWJaTg1ObkF
    MAzoK4gDFq/o1mLY877TVGGB/Is0tI248uqKKYdVuox5t1svP1QStTUwIjJQPidjBKSWGL
    +RcDjLXlQRLA2OlJOFRy69jMIa1ebW3Et2qssMhnOYqaqHiD218NXvRxXM3KQ4tTvrZ+WK
    Kq58WCg/aG9ac1exG6eSNLZVZMbdxvAWdnxAGYuXKEYavoFFdedhmRvR+MOb+qF9eHUwVy
    U7zuKkz2tyRP8tCvy3f5tE7qy2pbunC88znlmQY2ApqDQahqE7xauNJpLodw
X-ME-Proxy: <xmx:V7cFa7z-yVW7f0u4bQjZIiirC89for4MnT7VaQLL5gLF6bXPb2wQvQ>
    <xmx:V7cFa-zwQIIp-F6_nag2aZ07aYvvjI33KdiMqZRIwn5RS06yRCKXhw>
    <xmx:V7cFa7zGSxVNOTM5YTAN65O1gzRpUVzS4fFGX3x6JGXYRoYQBADkdw>
    <xmx:V7cFawZDNph8sy9QQ4u4KGIfqIP5Cn5dF57Gm4ByHjV_i63_m1EBOQ>
    <xmx:V7cFa24kUDPpwPOTOAt4mTPJnKOfZJINtZIYW9sW6obBRQcBi7EG7F2l>
Feedback-ID: ib2794684:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 11:12:06 -0500 (EST)
From: Michael Greenberg <michael@greenberg.science>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namei: don't count symlinks twice when a lookup restarts
In-Reply-To: <20261124035245.GX989762@ZenIV>
References: <87zeuz5o4j.fsf@hippogriff> <20261124031649.GW989762@ZenIV>
 <20261124035245.GX989762@ZenIV>
Date: Tue, 24 Nov 2026 11:12:06 -0500
Message-ID: <87o6be5hux.fsf@hippogriff>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On 2026-11-24 at 03:52:45 AM, Al Viro wrote:

> On Tue, Nov 24, 2026 at 03:16:49AM +0000, Al Viro wrote:
>> On Mon, Nov 23, 2026 at 02:44:28PM -0500, Michael Greenberg wrote:
>> > So a path that crosses n symlinks fails with -ELOOP if the RCU walk
>> > got through more than MAXSYMLINKS - n of them before giving up, which
>> > is possible for any n > MAXSYMLINKS / 2. A mount or umount anywhere
>> > on the system can make an RCU walk give up, since it changes
>> > mount_lock's sequence count, so whether such a lookup fails depends on
>> > unrelated activity. Opening the first link of a chain for 3 s, in a
>> > 4-CPU KVM guest, while another process mounted and unmounted a tmpfs
>> > in its own mount namespace:
>> 
>> You don't need mount to kick you out of RCU mode - just walk through
>> /proc/self/root/... at given step of the chain and you'll get deterministic
>> behaviour; no races needed at all.

The racy mount loop is how I hit the bug. A deterministic reproducer
would be much nicer, but I tried to build one and couldn't trigger the
bug.

It seems that proc's get_link (proc_pid_get_link()) returns -ECHILD in
RCU mode, and then pick_link() calls try_to_unlazy(), which could only
fail (as far as I can tell) with a concurrent change, like a mount. When
it succeeds, we continue in ref-walk mode with a correct count and no
restart.

Here's a run on an unpatched 7.3 host, with the proc link at positions 1,
10, 19, and last.

Links           ELOOP (out of 1000 calls)
21, 30, 40      0
41              1000

I get the same results through /proc/self/root, /proc/<pid>/root, and
/proc/thread-self/root. Code is at the bottom... maybe I messed up, or
maybe you meant a different approach?  The only other path I found that
returns -ECHILD to the caller without trying to unlazy itself is
security_inode_follow_link() in pick_link(), the SELinux invalid-label
case in inode_security_rcu().

>> Bug is real, but I'm not sure I like your solution - duplication
>> between path_init() and __set_nameidata() is confusing.  We can't
>> just drop that part of __set_nameidata() - it's possible to get
>> from set_nameidata() to restore_nameidata() without ever reaching
>> path_init(), e.g. in do_file_open() if alloc_empty_file() fails,
>> so it can't be dealt with that way, but...

I'm happy with either solution, though I think it's a bit clearer to
have just one line in `path_init` (rather than an invariant and sentinel
value to keep track of).

>> Let me think a bit; if we go with your variant, we'll need a very clear
>> comment along the lines of "it's not really redundant - removing either
>> will break things" added in both places.

Here's a draft of comments for my patch.

In __set_nameidata():

	/*
	 * path_init() sets this again at the start of every attempt, which
	 * is not redundant: a caller can reach restore_nameidata() without
	 * calling path_init(), e.g. do_file_open() when alloc_empty_file()
	 * fails, and restore_nameidata() copies this count back to the
	 * outer lookup. Without this assignment, restore_nameidata() would
	 * copy back an uninitialized count; without the one in path_init(),
	 * links are counted twice when a lookup restarts.
	 */
	p->total_link_count = old ? old->total_link_count : 0;

In path_init():

	/*
	 * Each attempt (the first, the ref-walk retry after -ECHILD, the
	 * LOOKUP_REVAL retry after -ESTALE) starts counting links again from
	 * the count of the lookup this one is nested in, if any, so that
	 * links an abandoned attempt followed are not counted twice. This
	 * repeats the assignment in __set_nameidata() on purpose; see the
	 * comment there.
	 */
	nd->total_link_count = nd->saved ? nd->saved->total_link_count : 0;

Would you like a v2 with these comments added? Alternatively, I'd be
happy to send a patch with your -1 approach (and similar comments in
__set_nameidata() and restore_nameidata()).

> One possibility would be
> 	p->total_link_count = -1;
> in __set_nameidata(), same change as in your variant in path_init()
> and
> 	if (unlikely(old) && now->total_link_count > 0)
> 		old->total_link_count = now->total_link_count;
> in restore_nameidata().  Not sure I like that variant, though...
>
> One thing to keep in mind is that reserve_stack() is not the only
> place where we bump that thing - follow_automount() is another and
> there we don't have nameidata on hand...

I don't _think_ this is an issue for follow_automount(), which receives
&nd->total_link_count (from handle_mounts(); follow_down() passes NULL),
which path_init() resets.

Overall, we make three kinds of attempts:

 - RCU mode
 - ref-walk, after -ECHILD
 - ref-walk with LOOKUP_REVAL, after -ESTALE

With the patch, each of these either uses the outer lookup's count or 0,
yielding -ELOOP after 40. An unlucky lookup that makes all three
attempts will follow up to 120 links (40 per attempt), but no successful
path will have more than 40. Before the patch, we stopped at 40 but
paths of 21 to 40 links could fail with -ELOOP early.

Michael

---
#!/usr/bin/python3 -I
#
# try to get a premature ELOOP using proc's root magic link
#
# Usage: proc-eloop.py DIR    (chains are built in fresh directories in DIR)

import errno, os, sys, tempfile

PREFIXES = {
    "self/root": ("/proc/self/root", 2), # /proc/self is a link
    "pid/root": (f"/proc/{os.getpid()}/root", 1),
    "thread-self/root": ("/proc/thread-self/root", 2), # /proc/thread-self is a link
}

def trial(total, magic, prefix, tries=1000):
    path, cost = PREFIXES[prefix]

    d = tempfile.mkdtemp(dir=sys.argv[1])
    open(os.path.join(d, "f"), "w").close()
    plain = total - cost

    for i in range(1, plain + 1):
        nxt = f"l{i + 1}" if i < plain else "f"
        target = f"{path}{d}/{nxt}" if i == magic else nxt
        os.symlink(target, os.path.join(d, f"l{i}"))

    eloop = 0

    for _ in range(tries):
        try:
            os.close(os.open(os.path.join(d, "l1"), os.O_RDONLY))
        except OSError as e:
            if e.errno != errno.ELOOP:
                raise
            eloop += 1
    return eloop

print(os.uname().release)
for prefix in PREFIXES:
    for total in (21, 30, 40, 41):
        cells = []
        for magic in (1, 10, 19, total - PREFIXES[prefix][1]):
            cells.append(f"@{magic}:{trial(total, magic, prefix)}")
        print(f"{prefix:16} {total} links, ELOOP of 1000:", " ".join(cells))
