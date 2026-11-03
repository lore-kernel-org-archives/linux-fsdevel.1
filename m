Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793735933;
	b=jhqiyjrTBe4wRMwQ3wckkvQ3mFGXMiMLRP/FO07Wp2FB6tH19ugpzKn/u6LZf5kN+JAB
	 xmim1yUnojGNBRKCx5nW+1Ri0sPt1cBdL6gV8V9VEwAKCDowJf6b5S8cbYOomq6ap+ytK
	 6aEAF0uuTFCWXIzL876V68Ew/sWWDMKAwVVKnqoj7U7sw3mhmjRAwbp89LtICtkLlfsbf
	 UWMW2suplbOpyb7aRLNECszrbLYxQfbLvs6oMh6oTkva2g6DPud9Le0Jxi6JT74JCxRdD
	 gYPeWfRi5VS09pS7Y+GeY1CBZ0tLeTTHRO+qvk0PNd1Qed01RG9RcChZ84OyroAQiMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type;
	bh=msC8AEF28+LoD4wR4QMW7ybuarkuRynrg91O2ZPZPW4=;
	b=1hyYL7uyle3V4/ElEw1M4Hr51qlORb286Mq6ZPkNuIeeesso62dYoyBItGhyBmhyO2kY
	 86UcRblOuTanByJrNUwQR2RpyX2xS5fb8Gv8tWeGwdITW9LGRm9qnlQAQtpffnxdErc8A
	 nqXUsXFsjcoT49W5CPU0x6qmaDMVu8yGCDXTcVxa8oxP6YwABKm7jyowopqa2aEaIHNkz
	 VQdTpYYX503mcT/dEkTTdJ23rOsX6fdF1N5Fqq5tiLUPqHxqjq5z4tlZJWyrcRR8Igp4D
	 3SxjmrGvbKmDWUUFuC+8Hu4obY3AgaX/aHYhi0jtRxeQulzkngCSbHAKhgZW3ztRHQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OUWKSaqv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86E606A31B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 19:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F86E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OUWKSaqv
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bcb6faf862so4310905e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 11:58:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793735931; cv=none;
        d=google.com; s=arc-20260327;
        b=Un74GYgmzl3E3QU21XnMdDTaL2YID2PReC/2NAP0iRIOO7CaZgClT/qyf9NsQGUg+U
         xHeJPPKGzytb91Tux3m262ksbA2uq8e9gSDrOSL3H9oopxEr6pjIjuIunof/HOhdvXy0
         xcdFuwZzE8xQbSfT9VtfZRl+A/bd3IG54TYRZ/FHgMu1+1xuxGe1y3jozcYHnsxGODm8
         N9SFsgJsD8kSGdyDwbs0AIoSpbL0hhp2j2Ot013sw+Fl+5Tro56AkvoAwPO4X0kns7cm
         RjjJtfdscFPdAxI4HT6S6KXoIM2HoK1ZsN687FXiWD2L592Lo/flGDV132QYrjdCW28t
         bunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=msC8AEF28+LoD4wR4QMW7ybuarkuRynrg91O2ZPZPW4=;
        fh=TuFmLk3btKi+FloCsWlWakC2C6OBiiEDVWKHQeA7yz0=;
        b=Vmt8S42XN40lLJS+6WHjeOBZTXRQ4UxmxXwTPz7jbPjSKYE+jnT8FAOHpojbQrdfcS
         jwBfGF/faMuvDCsTIldezAj/ozgGMx84Ui55MnZCXdsAQL+Kkv+UlY6oxcmhOBbkydZh
         W4ak+KEwqbYRHs89u35u6wRIbp597VaWYmV55qpPviO5ij93ghZkA0lTJUtrssyVCTrh
         18wBKF8KNQfO1sLR0di1cGAf4GblDXnOvyASEl0zuul8SAL+8x6d66JufXd0vedpMKOL
         3t51cYtKGO57mgyN7H9S6HIhCI7+c6lI0IQxC0KpC+RvfxviDN1QXKz28qxAnx9NJzJj
         WObA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793735931; x=1794340731; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=msC8AEF28+LoD4wR4QMW7ybuarkuRynrg91O2ZPZPW4=;
        b=OUWKSaqvQkmcspifGwE+EUFLnJNYnk1pd+X7y2Y3MaFNVGje4/4Zjo81naXmQymB0P
         erAk3MBi8RbpVw7hiycXO4gs4tyh0syx3KYCD7ME14rViIO7Ta3Hni5mYE2SGGfxxGBl
         fuxrht0kRuBtkV2SNJN8jNcHRk/Cm2Wd+f7P0R1b9a029msFihbfseZ5OZersC6LP0kB
         qkquA08gvdbVxN5omTGAqCDYYOvyJx1bVkxMDlotZipaQwCTzf1m4UdxQiyATCquPLFX
         dpB0MGGFQHAIcHbrVr1RjNrVbd7m6eKO7IMJz9qi0Ub7lFvBHrzdnpXjes1Uby4MQiTd
         N7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735931; x=1794340731;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msC8AEF28+LoD4wR4QMW7ybuarkuRynrg91O2ZPZPW4=;
        b=zkbsu9B41cI8ApDs5IIlM/WItMyLCZAwHmKxUapbzNvnKZM9BCC1GNodIKjo7NM7um
         epji6Aey/zqAGC0+oYYW7JGqyTHmArvZIRcpohBMbA6UMdEyxGG4oLu7TVZaOO8bhGzw
         9rE6N9lzuCpG9GbQxcXbGj4wixNKMhBgXNn5Lpv0y1sKFbc2QQSqX01f5PsfYykOrKfP
         ZWOLr5/TfVDx97maptabqLzSox2Hp9p5HAb+s0okVIQ6Lxdb4N1IuxX4cgiHuu2y6Be1
         p9jRTD9ZhtsR87dJb73MdnULcDdQbg7YKV8/F/Kj0QixTt7ePtZYsEuF99D8w290m9/7
         m1lA==
X-Forwarded-Encrypted: i=1; AKwUvBwLVHuEYpViJoLgS/3C4fjgllyhfa6JCD5X9R030aCwgW2NnWJeFSFsm8k8nH/UaiV5jPl8c4vSz/IEgKcX@vger.kernel.org
X-Gm-Message-State: APuU4Z+GZVYq1mvIkBZDUCjU/EYle80eNJHUuQoILLRos13+oQu3wwuj
	c2Th1C61W8Rp1/Yb/P1At2PrH8DSnDH5ZD+EU0Gaq2UZ2UIOwjoHNBY0Mw6qVBuBRktJh2DwtXM
	WzJVds3C81mBMUmwN+KBPHDHvVvUTt+WNcUGJUQDYUqugd5D3JVA5yg==
X-Gm-Gg: AYBFou0rxVYHko4SzPbUiROdtyh7uTHPA4TKHmHLm4WTKrwnFeam6OgCQRDWKwU5tyk
	MBW3BTC/al/TDtsyhvluQ0U27jaU2fMEckDB2bSxX6CMeGiGrHOOqGigWKOWj2+DlpiJVYJ+4yy
	e4O5uVV7waYIjCNSRgZKuG6vdxUKsnBh8nPIq3n566kZjUyAmEgU7hyCeKTUIijCvOj+5ZUVfqe
	JgW2CHppJ7Ldu8njOEt6tEO2w66vDmcSEFk/XRs7O3S2ChsakPmJ4KAJIyT1R8dXXSVJQZolxm+
	F+puM9zJKkj+w9B7JAAAdNidWrRiEW/JFV4wwcD2HK09f/gNdVOw9Ut8lWI1Rx4j1eYIDzdrKmJ
	5HGwDn1pklh8VAgz4tA8KmuoYJhlGf49/ng==
X-Received: by 2002:a05:6512:3044:b0:5bc:cb94:830b with SMTP id
 2adb3069b0e04-5bfd957fbc9mr4631201e87.55.1793735930576; Tue, 03 Nov 2026
 11:58:50 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 3 Nov 2026 11:58:38 -0800
X-Gm-Features: AclHuK_bN6YrhtswWu642OC1b8BtqaJiPZLecfCpjtFSxigsPxo-YRM7r02qtCE
Message-ID: <CALCETrWDJKr=LMzfPjwwRRuKapFKQ_OaYF6qYz-9Cs91xAXUgA@mail.gmail.com>
Subject: Accidental mountns/tmpfs API break from 2016?
To: "Eric W. Biederman" <ebiederm@xmission.com>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi-

I (well, an LLM following my rather explicit instructions) just wrote
a little tool to make a tmpfs as an unprivileged user: it unshares
userns and mountns, makes a tmpfs, fchdirs to it, and prints
/proc/PID/cwd to stdout.  Full source below.

I was a bit surprised that trying to create anything in the tmpfs did
not work without a uid_map and gid_map.  It looks like it came from:

commit 036d523641c66bef713042894a17f4335f199e49
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Fri Jul 1 12:52:06 2016 -0500

    vfs: Don't create inodes with a uid or gid unknown to the vfs

    It is expected that filesystems can not represent uids and gids from
    outside of their user namespace.  Keep things simple by not even
    trying to create filesystem nodes with non-sense uids and gids.

    Acked-by: Seth Forshee <seth.forshee@canonical.com>
    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>


Now my tool won't actually run on a pre-2016 kernel due to use of
fsopen, and I'm not about to say that a decade-old commit broke my ABI
and needs to be reverted.  But I am rather curious whether this rule
actually makes sense.  I'm not creating an idmapped mount, and I'm
using tmpfs, which could not care less about the mapping as far as I
know.

Would it make sense to only enforce this for filesystems that care?

--Andy


#include <cerrno>
#include <cstdio>
#include <fcntl.h>
#include <linux/mount.h>
#include <sched.h>
#include <string>
#include <string_view>
#include <sys/syscall.h>
#include <system_error>
#include <unistd.h>

namespace {
void Check(long result, const char *operation) {
    if (result < 0)
        throw std::system_error(errno, std::generic_category(), operation);
}

struct OwnedFd {
    int fd;

    ~OwnedFd() { close(fd); }
};

void WriteAll(int fd, std::string_view bytes) {
    while (!bytes.empty()) {
        auto n = write(fd, bytes.data(), bytes.size());
        if (n < 0 && errno == EINTR)
            continue;
        Check(n, "write");
        if (n == 0)
            throw std::system_error(EIO, std::generic_category(),
"zero-length write");
        bytes.remove_prefix(n);
    }
}

void WriteFile(const char *path, std::string_view bytes) {
    OwnedFd file{open(path, O_WRONLY | O_CLOEXEC)};
    Check(file.fd, path);
    WriteAll(file.fd, bytes);
}
}

int cmd_temp_shm(int argc, char **) {
    if (argc != 1) {
        fprintf(stderr, "Usage: lktool temp_shm\n");
        return 1;
    }

    try {
        auto uid = getuid();
        auto gid = getgid();
        Check(unshare(CLONE_NEWUSER | CLONE_NEWNS), "unshare user and
mount namespaces");

        /*
         * The outside UID and GID need to be mapped in order for the
outside tasks
         * to create dentries.  This comes from commit 036d523641c6
("vfs: Don't create
         * inodes with a uid or gid unknown to the vfs"), which I
think may have been
         * a mistake.
         */
        WriteFile("/proc/self/setgroups", "deny\n");
        WriteFile("/proc/self/uid_map", "0 " + std::to_string(uid) + " 1\n");
        WriteFile("/proc/self/gid_map", "0 " + std::to_string(gid) + " 1\n");

        OwnedFd context{static_cast<int>(syscall(SYS_fsopen, "tmpfs",
FSOPEN_CLOEXEC))};
        Check(context.fd, "fsopen tmpfs");
        Check(syscall(SYS_fsconfig, context.fd, FSCONFIG_CMD_CREATE,
nullptr, nullptr, 0),
              "fsconfig create tmpfs");

        OwnedFd mount{static_cast<int>(syscall(SYS_fsmount,
context.fd, FSMOUNT_CLOEXEC, 0))};
        Check(mount.fd, "fsmount tmpfs");
        Check(fchdir(mount.fd), "fchdir tmpfs");

        // The detached mount is kept alive by cwd and the mount descriptor.
        // No mount is attached to the inherited filesystem hierarchy.
        std::string path = "/proc/" + std::to_string(getpid()) + "/cwd";
        path.push_back('\0');
        WriteAll(STDOUT_FILENO, path);
        for (;;)
            pause();
    } catch (const std::system_error &e) {
        fprintf(stderr, "lktool temp_shm: %s\n", e.what());
        return 1;
    }
}
