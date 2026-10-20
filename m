Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494477;
	b=NH5uhMwsHYQ/mwrYidapm89535QXUKjyWtep/+NOdNyZJ0yoey3JsT1hjBfB9mqzU3nN
	 sbjmaBzEyPPFf67hGE1g+g1CxwxMq9bQDRgm2ji+d+VuTGDRMWr4hkgDbStUfhekB2dr9
	 7fu64VrOpL/uLO9XmqQ8MbusR52aSHQzRD+/dDWZHhd4dy6cujvvgXFmmUrby+XFyc25C
	 BzDTt6S+nOfWton/lFApcgBHqXmjRECxRiXTddoZHv4GklNCkVLh1d39ZN9JZ+hIPNZx/
	 hKHk5ehrO4Aj95cT/w6hvqMS6d+4cqbNcWDEFxfO2AMcqO12PLVpC9K7zxgKsMOZG1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494477;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=2kHi/Es8dkIPmkb5B6JokKevhVaE/UvcT1ONLUVioHQ=;
	b=uZN0vRkfxv+vegJLjDYVVJAE5IT1euIKBOIR1LvExbGsTrnNoL6x15QVUP8CVfjDKITu
	 BxQJPbJ2K+EMm9KsjKnaHkif5SCQYelkInCE3qMCA7sOQHazxe7TepqZqRcMCIj3eP3vj
	 g4+PsSS2YB16ncwv8L1jkUTTPNWmFrCzuGZbEdnhUSkLoJy1Hjdm7JpeQ337Bw5cZ9H9r
	 nEfITPl0IRlu4w9W4/1iIP14OF8UcFWtnZDyQXAvpOp8mqTsgK0YPTneE7h6xM2tV4zpK
	 Mx14FYDX06RXmw8/kgo5+wJXuCyKn+jo0HQIn+ADINCoX4lJJzckHtoVFtdZpSEGn4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DzeiU0cn;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5CF606A31D;
	Tue, 20 Oct 2026 11:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B5CF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DzeiU0cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2k
	Hi/Es8dkIPmkb5B6JokKevhVaE/UvcT1ONLUVioHQ=; b=DzeiU0cnhtJTCWbykx
	CFDqNbStxV6LH+OPTjbTUcpEk8MoOi2AzdLP8eFVnBNo453RNHTCcqIQ6X8Iha3Z
	hdEBe9HvwJEWGvWd578t4m5Zh2Mf0rLEqv2qugXH1wf6KmaE/T7SQ8VGo7cC4UvF
	rTZ7Cwl4sZsbkrgEjoyd/NKJs=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3fwKDS9dqImAiBg--.35613S2;
	Tue, 20 Oct 2026 19:07:47 +0800 (CST)
From: shaos <shawnq1@163.com>
To: brauner@kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] fs: statmount writes an empty UID-map string past bufsize
Date: Tue, 20 Oct 2026 11:07:47 +0000
Message-Id: <20261020110747.959829-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fwKDS9dqImAiBg--.35613S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw1rCFWfCryxXF4UuF18uFg_yoW5Xr1fpa
	909w1FgF1kXFsYyr9Y9a18Xw1rWF9ay3W7W395Xrn8ua4Ygryjgr1xtayakF429rZ5G3Wj
	vrZ093Z29wsYqwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UuE__UUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC0ASEkmrXS4RA3AAA3s

Hello,

statmount() can return success after writing one byte outside the caller-declared buffer when STATMOUNT_MNT_UIDMAP is requested for a non-idmapped mount with a short nonzero buffer.

For a 100-byte buffer, statmount_string() reserves an empty-string NUL, but statmount_mnt_uidmap() emits no text for the non-idmapped mount. The seq->count == start return skips the string-size check. copy_statmount_to_user() then copies the reserved byte at buf + sizeof(struct statmount), which is offset 512 on x86-64. The PoC observes the byte at offset 512 change from 0xaa to 0x00 while the syscall returns success and reports size=101. A guard-page variant returns EFAULT. The non-empty-string EOVERFLOW and non-string short-buffer controls do not write the sentinel.

This is a write past the declared userspace buffer, not kernel-memory corruption or a demonstrated cross-process write. The UAPI comment says an undersized buffer for string fields returns EOVERFLOW.

HEAD commit:    24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
source version: Linux 7.3.0-rc7
architecture:   x86-64
compiler:       gcc 11.4.0, GNU ld 2.38
QEMU:           6.2.0

console output: https://gist.githubusercontent.com/shaos26/b1957e09840ff4132181bb0498515b17/raw/d28102014b7fce8474658331d19ae8270b96c683/console-output.txt
kernel config: https://gist.githubusercontent.com/shaos26/b1957e09840ff4132181bb0498515b17/raw/baa5ee61ce748667104c480560ab5116a100e3fd/kernel-config.txt
reproducer: https://gist.githubusercontent.com/shaos26/b1957e09840ff4132181bb0498515b17/raw/af16c41b0afbc29d186d0295429bf95c1f608c23/poc.c

Build the kernel from the revision above with the attached config. Build the static PoC with:

    gcc -D__EXPORTED_HEADERS__ -static -O2 -Wall -Wextra -Werror \
        -I linux/include/uapi -I linux/arch/x86/include/uapi -o poc poc.c

Place it as /init in a minimal initramfs containing /dev/console, /proc, /sys, and /tmp, then boot the exact kernel under QEMU:

    qemu-system-x86_64 -m 2048 -smp 2 \
        -kernel build/arch/x86/boot/bzImage -initrd initramfs.cpio \
        -append "rdinit=/init console=ttyS0 panic=-1 kfence.sample_interval=0" \
        -display none -monitor none -no-reboot

Two exact-revision boots produced STATMOUNT_UIDMAP_EMPTY_OOB_INDEPENDENT_CONFIRM and exited cleanly. The one-byte destination is within the process's own mapped address space; no privilege escalation or kernel memory corruption is claimed. The affected code path is still present in upstream master f47d223627f8; runtime validation was on v7.3-rc7.

Thanks,

shaos

