Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76B443E2F;
	Fri, 16 Oct 2026 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136623; cv=none; b=P5LsgGBoLqEZR05+huJTNMIt313b8baQqw2Hwth0MUaCLvC0YAnB1n84fJYT4XUJee2yGGWtRb/TV+lK2IEMTZ9UkyaVQHZ1E3u8umJOdd/PUvu3J60XQ425+YpFh1eoH3TCAeppal7M5ZEiSS7dTjR1ae/NbFIF1xcTUAWN+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136623; c=relaxed/simple;
	bh=ZbJcutHy3x4GvXyVBwyZjp6E+0OsKMimbzeuwxsHg7s=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=ohvTXA7KP2K67K87tJJcOgO+7xzqn2qwiCdRAAjm+DtjQVMD94NJxfQAIhvkn2ZXydDwb6QJNhvvIidaUUmP0yuQHZtsaFB9wqpDd6yyd3vYs8bF1YidHXhS+yoEfydwboW7Ks9tlEpvkNssfrP4pTBzz95twxm02hmNrbp/pX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rwQOFadM; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rwQOFadM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792136613; bh=h8HvQyIX57qBISjJasw1hsyChRsReBVt6kvOdPCGiEg=;
	h=From:To:Cc:Subject:Date;
	b=rwQOFadMeWF8RS7hbtOZhISkPVW2RoKii9ZDfrxrPWQsyjJTmQ60BFE/HKmkoRz1/
	 Vb9dvrwKOF2td/h+FcqNf5AZoBnfYug472WWZWc8RSUVsv+czvyCGe9iPHkpZfE250
	 SJLSNNzG6q0kCTf+yglLEPCel3R143HRiL4TXn7w=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id A07860BD; Fri, 16 Oct 2026 15:40:07 +0800
X-QQ-mid: xmsmtpt1792136407tvps9yzhi
Message-ID: <tencent_AC9ADF8723B74E37A6BC51DC3EDA5132A908@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5nDvw11v3BD312iz/N/ux8huwZ5GXpIy+aB4pjVYNmjZ5/7NZXf
	 PBfDsUc7+imOilFAeBUFQ3oJVgsSiKfVn9sNiKZRAn+lHpaDNEzkHDTVc+exTQ8tj0d5UCz2d+re
	 EoiZNbgq7DplQKZMeUWlqmnREnl8zMrPzYoh/MI3DP+kUKS5G4iTEiH7y5zyntmOD70nV5HFZ9me
	 nxL8OFOvXG2f2n/INJYkuTSfocHEjnTbNNTt0ntG5LfBR70yp8F73fQZQF1xGKZ0JeuDlT8MqFXO
	 k9gLDfrXWoOcXuGWR2bSLBEl0liildwmeVlRus8g6ruUOom1CCXdZU2gNaojkSTyW6PpsXOWXWrs
	 Hn4wBnGlP0jFigazm3JjtqzYqhkYBS+50BLFlr2fY3ym6U4w4Sg0b/mVDa+aDlE7Fr/vz2OdPTAP
	 KO3dDGdhTmMgBrO6h36cMIdv9rd1AW6aXNDeLZ+k40q7WGd7RV8FoFnGmlmkShKkVeoEDOTyI4FA
	 ii0PtKUfos+eVtXCM3kJWbt/UaR+cjnOloU7B0Mp3Cy4MLRhMQKLynNUdYXNl+lH2MamtRDmdXw6
	 T4NNh8+vi+QvshiBo8nZ7uS8u3MaR8J+xFWKsY9usZ6woPT4yDdPMjGB8/OmLFGlKXpsrXM60FRW
	 fyb11W/mQ69KoQJfXJRlHmssF0uGKXTUMal/koPAweH6SvbBYDXgORy62I+mPSyWOcEGDNYODBdF
	 hosV+Yj/NMgZatrXsLe721a7eSa4NUO55ofmLZMfTSy2SMU0a36ALq8Li7P1jQZGT4Q0NSE9bo9N
	 OeJ4Fqre6qjo+lh8U4Oke79lO++Qmk/Jt/GhfDmfs09UgkksFFEraURZ6VcQOVq2TvE3Eujxudw4
	 OekFASDZgJL8YF4/HsINwuIsiUBhcExKLFBscLDxh52PgM8tl9hXIzk6e520aQuWawYMMLysgQlp
	 j3xXBqB2pvHt0yoVQzu3E4Ou6OxGRgHPV2t37T/ravzTUIklAhg1W2Yo/TQwsGsjFdokGyFnoZg5
	 Ph+RAhIuReb/MVfDG8sPzG5Lm0no6fWOuDvwumnnq6ga+obProOxTaJSUIBsZEkRTQihC5p9pCcq
	 RtIbWpTKIIdI8pv3lmaq5GlL7EDPhxMoNo10sf
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: yangguikun <yangguikun19@qq.com>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [BUG] jfs: unvalidated log superblock fields in lmLogInit() panic the kernel on mount
Date: Fri, 16 Oct 2026 15:40:07 +0800
X-OQ-MSGID: <20261016154007.85464-jfs-yangguikun19@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Dave,

Mounting a crafted jfs image that uses an external log makes lmLogInit()
trust three on-disk fields in the log superblock without any range check,
which ends in a kernel panic.  It is deterministic: 3 out of 3 runs on
7.3-rc7, mount crashes, no write needed.  The fields are size, l2bsize
and end; l2bsize is the one that reaches the crash here.

Trigger
-------

    mount -t jfs -o loop crafted.img /mnt/x

The image has to be one whose log lives on a separate device (the usual
"external log" layout), and the log's superblock in block 1 carries an
out-of-range l2bsize.  Mounting a block device needs CAP_SYS_ADMIN, as
with any filesystem image; nothing else is required.  A control image
that differs only in l2bsize = 12 mounts and runs normally.

Root cause
----------

lmLogInit() reads the log superblock and validates only magic, state and
uuid:

    fs/jfs/jfs_logmgr.c:1287-1314
            if ((rc = lbmRead(log, 1, &bpsuper)))
                    ...
            logsuper = (struct logsuper *) bpsuper->l_ldata;
            if (logsuper->magic != cpu_to_le32(LOGMAGIC)) { ... }
            if (logsuper->state != cpu_to_le32(LOGREDONE)) { ... }
            } else {
                    if (!uuid_equal(&logsuper->uuid, &log->uuid)) { ... }
                    log->size    = le32_to_cpu(logsuper->size);
                    log->l2bsize = le32_to_cpu(logsuper->l2bsize);
                    ...
                    log->page    = le32_to_cpu(logsuper->end) / LOGPSIZE;
                    log->eor     = le32_to_cpu(logsuper->end) -
                                   (LOGPSIZE * log->page);

Neither size nor l2bsize nor end is range-checked, and l2bsize here
overwrites the sane value that lmLogInit() had just set
(jfs_logmgr.c:1269 sets log->l2bsize = L2LOGPSIZE for external logs).  It
is then used directly as a shift count:

    fs/jfs/jfs_logmgr.c:1892
            bp->l_blkno = log->base + (pn << (L2LOGPSIZE - log->l2bsize));
    fs/jfs/jfs_logmgr.c:2018
    fs/jfs/jfs_logmgr.c:2088
            ... << (log->l2bsize - 9);

With l2bsize = 13, "L2LOGPSIZE - l2bsize" is negative and "l2bsize - 9"
is 4, so the computed block number / sector is garbage; the bogus I/O
that follows trips a use-after-free in the same function and the mount
dies.

Note the asymmetry inside the same function: the inline-log branch
(jfs_logmgr.c:1306-1308) does check the on-disk size against the
in-memory one and rejects a mismatch, while the external-log branch only
compares the uuid.  The size field is unchecked there too, so
log->logsize = (log->size - 2) << L2LOGPSIZE (jfs_logmgr.c:1385) can go
negative as well; I reproduced the l2bsize case.

Crash
-----

    UBSAN: shift-out-of-bounds in fs/jfs/jfs_logmgr.c:1892:32
    shift exponent -1 is negative
    ...
    UBSAN: shift-out-of-bounds in fs/jfs/jfs_logmgr.c:2018:28
    UBSAN: shift-out-of-bounds in fs/jfs/jfs_logmgr.c:2088:28
    ...
    BUG: KASAN: slab-use-after-free in lmLogInit+0x16dd/0x1a90
    Read of size 8 at addr ff110000413e4218 by task mount/8208
    Call Trace:
     <TASK>
     kasan_report+0xca/0x100
     lmLogInit+0x16dd/0x1a90
     lmLogOpen+0x...
     jfs_mount_rw+0x...
     jfs_fill_super+0x...
     ...
    Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
    RIP: 0010:___free_pages+0x15b/0x190
    Kernel panic - not syncing: Fatal exception

Three runs on three fresh VMs, all with l2bsize = 13, all panicked; the
control (l2bsize = 12, same image otherwise) mounted with no UBSAN and no
KASAN.

Suggested fix
-------------

Validate the three fields before using them, the way the inline branch
already validates size.  For example, require l2bsize to match
L2LOGPSIZE for external logs (or at least bound it), and reject size < 2
and an out-of-range end:

    --- a/fs/jfs/jfs_logmgr.c
    +++ b/fs/jfs/jfs_logmgr.c
    @@ ... (in the external-log branch of lmLogInit, after the uuid check)
    +       if (le32_to_cpu(logsuper->l2bsize) != L2LOGPSIZE ||
    +           le32_to_cpu(logsuper->size) < 2) {
    +               rc = -EINVAL;
    +               goto ...;   /* existing error path */
    +       }
            log->size    = le32_to_cpu(logsuper->size);
            log->l2bsize = le32_to_cpu(logsuper->l2bsize);

(The exact placement and the error label depend on how you prefer to
structure it; the existing "free logsuper and return rc" path is fine.)

Versions
--------

Reproduced on 7.3-rc7.  The external-log branch in the 7.2 tree I checked
reads and uses the same three fields the same way, with the same missing
check.  I could not produce a Fixes: tag: the kernel trees available to
me are not git repositories, so I have no verifiable commit to point at
and did not want to guess.

Thanks,
yangguikun <yangguikun19@qq.com>

