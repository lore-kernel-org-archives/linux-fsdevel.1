Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4140F8D8
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037798; cv=none; b=dvqHg161Z7g7FLdjnOkpvUA/xWm3Wcr7tLI77mdDs/lAtQa6R8ZsA727XYH2qCqUQu6T++Z+6C/NDjpiyex1rjwj8Eq/LZRzp4rdtabGMUrp5+1AwLSoFUM6hDsrDxBLuTIATupa4UE5dNiXsQJRSn7EBA9cgpgGcuTd3z8o0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037798; c=relaxed/simple;
	bh=1YAAaw+LN5HxGKDzBK+G7iohFaXTkWs7NfA6HZJG6+s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=WkDAaWmeTzfs7dXOMbAP5doeZZgKor7QjeepHypU3jI6s9OdwDNJ+n1X11VzW9JIHRtRmiSg6Ikhxf6diBa55mVhTgalXePiVpTjPGsmUETo6QoUp0I+eRlwk9HsIS2mIJUgLqK6Bkcj5g5ZCK/NGdqpzgUMuHSLUKra1Fuzwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=method-b.uk; spf=pass smtp.mailfrom=method-b.uk; dkim=pass (1024-bit key) header.d=method-b.uk header.i=@method-b.uk header.b=KEzvSuYz; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=method-b.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=method-b.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=method-b.uk header.i=@method-b.uk header.b="KEzvSuYz"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b94fce6e8so10089615e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 03:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=method-b.uk; s=google; t=1789037787; x=1789642587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NaG86XO6iGY8X3rPt+FM7bhS++94ucCr96dw0ZAjXyk=;
        b=KEzvSuYzCU/Tiwi4LfJ58twJip5VPVjhlbhMDJ/jFnopvj0WvYJjJ0P8CUp98LMxL/
         Sz8x5j1Q3cvU65LGS1Xlx+rEPF8+cLMaGBkYpQfqgQ+hIxxZSAO16n2zuGShkOAzOoKc
         TAJCi/0opfrinu9XQ7cyyt0spq0SVRRDGhwZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789037787; x=1789642587;
        h=content-transfer-encoding:content-type:cc:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NaG86XO6iGY8X3rPt+FM7bhS++94ucCr96dw0ZAjXyk=;
        b=FxtE+1X8zWrzS5/UWsi0zFxUcK9mXLl/0DP6T6QQCDH5sIWQfRxQD92B8gfeCFJMSh
         WaQrffrF/M4KYGVzQQwU1Ycx0J4mq2afI4TCMVw86DUy4/rA47PQPUFBP7/icuS35GoQ
         s8qkBcACdXcbcVWaPPNCfedImzLHMlnNwYLe1GQVN4dSMSG3oRBR89bXeFQx8wUW4MqW
         m1BbjJE5sr5prKOCPO8kpg2rB2S/8IheSBf2wPOYl6ep7tZZB6cT3NS24qblMUYtt9B3
         otgxsYV5znrDN/b1wBwB2ehMUyfM0u8f7OXrCSYjwRRPQnruPNmlAptK7MX1L/9dwdFl
         OwRA==
X-Forwarded-Encrypted: i=1; AKwUvBzv2CqGSajvws/jHiPLyBxnT+ainwy1KIQNrcwNLFG5C/t+HQpr7D6Mz71Zx3PFh6F8sC161qAQALBo+ZsT@vger.kernel.org
X-Gm-Message-State: AFuF++kUcLRofcWuLeXGm6BC6j7Fto54ZkIyHkYQFubovETxGk9DbY2L
	gPLhuAtxCt/91P234HsBQ/oOovNWT+40qiy3GgY9K2kDZCUJAzBlLk1f0cqSuADVqno=
X-Gm-Gg: AYBFou0P+EbMA3cILGdqF3ObY4GGJYy3Z6y1PEhY54iKZ9+AwRzoc6Q6/Ci1L7uiXCD
	kgyedaR7MFwa6UewbLW6TtiaDwlP9LcSyrNmMfkiKnJq3O5+oHJQ0RYw/dw5EfLvsirZ6nYkWM5
	H/HaSDmazz4Atwv9K0x50kBjLxV6tvdhphktC2Q3SuRXemuKyVZcmhPzd3TMpcfeun4uLuPXEyO
	zPvgrg9Xx38CNsJPYLtHCq4K6DFC51lxwsREQv6swnS/rVetkbdasoILDwp60mjlQL9bX+6ZFlK
	qXK0UgK6RmV9Kvo3CJnLMrCi9soJyPkgC5nsZuiBN4Ox+7HEZOqouNrePdaAXY1aeUs9JcLrqsg
	eY5C5Yh2a9TW86+avH9tsxgXEBGUTxMeKorrtk8kd1kgc/2XJPp7tmlkFNrG/U7A3iOTzBqxEM2
	4DC1n+a57u9Gajc98CVGLpdxUNQEMhtJtBM+wmjNPn+T78SR8sBOhceJ/BUO1HDx9zMdL+UGZ0Z
	crtR4Uje9sFzmLEHA5yapyW0hsDK6zQeTjdt4khbyq8/vUu2y7KbTmHxG1CNt8dEbSOr+EmjamT
	ycIdclJq2T42/g==
X-Received: by 2002:a05:600d:849a:20b0:49c:de80:b833 with SMTP id 5b1f17b1804b1-49d258cdad4mr46039065e9.2.1789037786340;
        Thu, 10 Sep 2026 03:56:26 -0700 (PDT)
Received: from [192.168.1.182] ([193.9.15.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm71059335e9.15.2026.09.10.03.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 03:56:25 -0700 (PDT)
Message-ID: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
Date: Thu, 10 Sep 2026 11:56:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Michael Mulqueen <mike@method-b.uk>
Subject: PROBLEM: [REGRESSION 7.1-rc4 -> 7.1-rc5] 9p: silent NUL corruption of
 file data on cache modes with CACHE_WRITEBACK
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 dhowells@redhat.com, pc@manguebit.org
Cc: linux_oss@crudebyte.com, v9fs@lists.linux.dev, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

This is my first kernel bug report, so let's hope I've done it right!

[1.] One line summary of the problem:

A 9p mount returns NULs in place of file contents the server holds, and can
write those NULs back over the server's copy. Nothing reports an error - the
read succeeds and the file is the correct length. Affects CACHE_WRITEBACK 
modes - mmap, loose and fscache - but not none or readahead.

[2.] Full description of the problem/report:

I enclose a reproducer script that shows the two presentations of this bug:

  - Read side: a range whose folio has been evicted reads back as NULs 
    while the server's copy is intact. The whole file comes back as NULs. 
    A fresh open() on the same mount reads them too, so it is not
    confined to one descriptor.

  - Write side: A partial write into such a range destroys data the server
    did hold.

I came across this bug on a cache=loose mount in ordinary use, I was seeing
this sporadically and I think git was usually the trigger. I switched to 
cache=mmap, which made it rarer but did not stop it.

After the client's own writeback extends a file, zero_point appears to go 
stale and the zero-fill branch in fs/netfs/buffered_write.c fires for 
regions the server does have. The sites were that branch, fs/9p/vfs_inode.c 
(use_zero_point = true to netfs_inode_init), and fs/netfs/misc.c.

This looks like a client-side problem - it reproduces against 3 independent
server implementations (see [7.]).

[3.] Keywords:

9p, v9fs, netfs, filesystem, data corruption

[4.] Kernel information

[4.1.] Kernel version (from /proc/version):

Linux version 7.3.0-rc2-p9repro (ubuntu@p9-repro) (gcc (Ubuntu
15.2.0-16ubuntu1) 15.2.0, GNU ld (GNU Binutils for Ubuntu) 2.46)
#3 SMP PREEMPT_DYNAMIC Wed Sep  9 11:25:31 UTC 2026

[4.2.] Kernel .config file:

Built from the distribution config with debug info and module signing turned
off. The options that bear on this:

    CONFIG_9P_FS=m
    CONFIG_9P_FSCACHE=y
    CONFIG_NET_9P=m
    CONFIG_NET_9P_FD=m
    CONFIG_NETFS_SUPPORT=m
    CONFIG_FSCACHE=y
    CONFIG_CACHEFILES=m

[5.] Most recent kernel version which did not have the bug:

v7.1-rc4 is clean. v7.1-rc5 is the first build I have found that corrupts.

Every row below is the same VM and the same userspace; only the kernel
changed. Mainline builds are the Ubuntu mainline PPA ones from
kernel.ubuntu.com, unmodified.

    v6.18       clean
    v7.0        clean
    v7.1-rc1    clean
    v7.1-rc4    clean
    v7.1-rc5    CORRUPT     <-- first bad
    v7.1-rc7    CORRUPT
    v7.1        CORRUPT
    v7.2        CORRUPT
    v7.3-rc2    CORRUPT

"CORRUPT" is 20/20 on both checks on mmap, loose and fscache, and 0/20 on
none and readahead, in every affected build.

Ubuntu's 7.0.0-30-generic also corrupts, which is where I first hit this;
mainline v7.0 does not - presumably backported.

I then built and tested the likeliest commit and its parent:

  - 2c8f4742bb76 ("netfs: Fix potential for tearing in ->remote_i_size and
    ->zero_point") - clean.

  - 4543a4d73794 ("netfs: Fix zeropoint update where i_size >
    remote_i_size") - CORRUPT.

[6.] Output of Oops.. message:

Not applicable: no oops, no warning, no error return.

[7.] A small shell script or example program which triggers the problem:

A self-contained reproducer is enclosed - it requires root.

It starts its own diod, mounts each cache mode in turn, runs both checks 20
times against each, and cleans up. The 20 is repetition rather than a
sample - the sequence is deterministic. On 7.3.0-rc2 it gives:

    kernel: 7.3.0-rc2-p9repro
    20 iterations per mode. read = client returned NULs the server does
    not have; write = server's copy damaged.

      cache=none       read   0/20  write   0/20  [cache=0x0]
      cache=readahead  read   0/20  write   0/20  [cache=0x1]
      cache=mmap       read  20/20  write  20/20  [cache=0x5]
      cache=loose      read  20/20  write  20/20  [cache=0xf]
      cache=fscache    read  20/20  write  20/20  [cache=0x8f]

The write check reads the server's copy directly; the read check compares
what the mount returns against it. The script verifies the kernel applied
the cache mode asked for, and adds a cachetag= for fscache.

diod is used because it is packaged in Ubuntu and the setup is easy. It 
has to be mounted -o ignoreqv, since it reports qid.version = 0.

Every kernel listed in [5.] was also checked against QEMU's virtio-9p
server (-fsdev local / -device virtio-9p-pci), mounted with no ignoreqv and
no other special options. The results match diod exactly.

Originally found against rust-p9 (https://github.com/google/rust-p9).

[8.] Environment

[8.1.] Software (output of ver_linux):

    binutils              2.46          kmod                  34.2
    bison                 3.8.2         Linux C++ Library     6.0.35
    Console-tools         2.7.1         Module-init-tools     34.2
    Dynamic linker (ldd)  2.43          Mount                 2.41.3
    e2fsprogs             1.47.2        openssl               3.5.5
    flex                  2.6.4         pahole                1.31
    GNU awk               5.3.2         procps                4.0.4
    GNU C                 15            Python                3.14.4
    GNU make              4.4.1         Rust                  1.93.1
    GNU tar               1.35          udev                  259
    GRUB                  2.14          util-linux            2.41.3
    iptables              1.8.11
    Kbd                   2.7.1

(ver_linux's "Modules Loaded" line omitted; see [8.3.])

[8.3.] Module information (from /proc/modules):

    9pnet_fd    24576   0 - Live
    9p          81920   0 - Live
    9pnet      106496   3 9pnet_fd,9p,9pnet_virtio, Live
    netfs      614400   2 9p,9pnet, Live

[8.7.] Other information that might be relevant:

I did a quick check against a cifs mount (cache=loose, cache=strict and 
cache=none) and could not replicate there.

I searched the v9fs and netfs public-inbox archives and did not find this
reported - apologies if I have missed a thread. 

The nearest existing thread is Pierre Barre's "[BUG] 9p: data corruption
with cache=mmap under concurrent stat/write" (24 Dec 2025). I believe that
is a different bug: it needs stat racing against writes and manifests as a
wrong i_size. What I have here is single-threaded, deterministic, and
destroys data rather than mis-sizing the file. It is also absent on v6.18,
the release that report was made against.

[X.] Other notes, workarounds:

You can mount with cache=readahead or cache=none, but with a loss of 
performance and various programs misbehave without mmap.



--- p9-nul-repro.py ------------------------------------------------------

#!/usr/bin/env python3

import contextlib
import os
import shutil
import socket
import subprocess
import sys
import tempfile
import time

# Bitmask as reported in /proc/mounts; cache=none is the default, not printed.
CACHE_BITS = {"none": 0x0, "readahead": 0x1, "mmap": 0x5, "loose": 0xf,
              "fscache": 0x8f}
SMALL, BIG = 4000, 12000
MSIZE = 524288
PORT = 5641
ITERATIONS = 20
MODES = list(CACHE_BITS)


class Lab:
    def __init__(self):
        self.base = tempfile.mkdtemp(prefix="p9nul.")
        self.export = os.path.join(self.base, "export")
        self.mnt = os.path.join(self.base, "mnt")
        os.makedirs(self.export)
        os.makedirs(self.mnt)
        self.srv = subprocess.Popen(
            ["diod", "-f", "-l", f"127.0.0.1:{PORT}", "-e", self.export, "-n"],
            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        for _ in range(160):
            with contextlib.suppress(OSError):
                socket.create_connection(("127.0.0.1", PORT), timeout=0.25).close()
                return
            time.sleep(0.05)
        sys.exit(f"error: diod did not listen on 127.0.0.1:{PORT}")

    def mount(self, mode):
        """Mount one cache mode; return the bitmask the kernel actually used."""
        opts = (f"trans=tcp,port={PORT},version=9p2000.L,msize={MSIZE},"
                f"cache={mode},aname={self.export},uname=root,access=any,ignoreqv")
        if mode == "fscache":
            opts += f",cachetag={os.path.basename(self.base)}"
        r = subprocess.run(["mount", "-t", "9p", "-o", opts, "127.0.0.1", self.mnt],
                           capture_output=True, text=True)
        if r.returncode != 0:
            if mode == "fscache":
                print(f"  cache={mode:10s} skipped - {r.stderr.strip()}")
                return None
            sys.exit(f"error: mount cache={mode} failed: {r.stderr.strip()}")

        # did we get the cache we asked for?
        got, found = 0, False
        for line in open("/proc/mounts"):
            f = line.split()
            if len(f) > 3 and f[1] == self.mnt and f[2] == "9p":
                found = True
                for opt in f[3].split(","):
                    if opt.startswith("cache="):
                        v = opt.split("=", 1)[1].removeprefix("0x")
                        got = int(v, 16)
        if not found:
            sys.exit(f"error: {self.mnt} is not a 9p mount")
        if got != CACHE_BITS[mode]:
            sys.exit(f"error: asked for cache={mode} "
                     f"(0x{CACHE_BITS[mode]:x}), kernel reports 0x{got:x}")
        return got

    def umount(self):
        subprocess.run(["umount", "-l", self.mnt], capture_output=True)

    def cleanup(self):
        self.umount()
        self.srv.terminate()
        with contextlib.suppress(subprocess.TimeoutExpired):
            self.srv.wait(timeout=5)
        self.srv.kill()
        shutil.rmtree(self.base, ignore_errors=True)


def stage(lab, name):
    """Extend a file through one fd and evict it, leaving the fd open.

    One fd throughout, and no path lookup or stat() after the open, so nothing
    drives a getattr to refresh the client's idea of the server's size."""
    client = os.path.join(lab.mnt, name)
    with contextlib.suppress(FileNotFoundError):
        os.unlink(client)
    fd = os.open(client, os.O_RDWR | os.O_CREAT | os.O_TRUNC, 0o644)
    os.pwrite(fd, b"A" * SMALL, 0)
    os.pwrite(fd, b"B" * (BIG - SMALL), SMALL)
    os.fsync(fd)
    with open("/proc/sys/vm/drop_caches", "w") as fh:
        fh.write("1\n")
    return client, fd


def server_copy(lab, name):
    with open(os.path.join(lab.export, name), "rb") as fh:
        return fh.read()


def read_check(lab):
    """True if the client reports bytes the server does not have."""
    client, fd = stage(lab, "rd.dat")
    try:
        seen = open(client, "rb").read()
    finally:
        os.close(fd)
    return seen != server_copy(lab, "rd.dat")


def write_check(lab):
    """True if a partial write destroyed data the server was holding."""
    _, fd = stage(lab, "wr.dat")
    try:
        os.pwrite(fd, b"C" * 192, 8000)   # partial write into an evicted folio
        os.fsync(fd)
    finally:
        os.close(fd)
    return b"\0" in server_copy(lab, "wr.dat")


def main():
    if os.geteuid() != 0:
        sys.exit("error: run as root: sudo ./p9-nul-repro.py")
    if shutil.which("diod") is None:
        sys.exit("error: diod not found (apt install diod)")
    for mod in ("9p", "9pnet"):
        subprocess.run(["modprobe", mod], check=False)

    print(f"kernel: {os.uname().release}")
    print(f"{ITERATIONS} iterations per mode. read = client returned NULs "
          f"the server does\nnot have; write = server's copy damaged.\n")

    lab, worst = Lab(), 0
    try:
        for mode in MODES:
            applied = lab.mount(mode)
            if applied is None:
                continue
            rd = sum(1 for _ in range(ITERATIONS) if read_check(lab))
            wr = sum(1 for _ in range(ITERATIONS) if write_check(lab))
            lab.umount()
            worst = max(worst, rd, wr)
            print(f"  cache={mode:10s} read {rd:3d}/{ITERATIONS}"
                  f"  write {wr:3d}/{ITERATIONS}  [cache=0x{applied:x}]")
    finally:
        lab.cleanup()
    return 0 if worst else 1


if __name__ == "__main__":
    sys.exit(main())

--- end p9-nul-repro.py --------------------------------------------------

#regzbot introduced: 4543a4d73794

Kind regards,
Mike

-- 

Michael Mulqueen

Method B Ltd
mike@method-b.uk
https://www.method-b.uk/

Method B Limited is registered in England and Wales with the company 
number 9189496. Registered office: 20-22 Wenlock Road, London, N1 7GU.
