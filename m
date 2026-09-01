Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80E3FF1AC;
	Tue,  1 Sep 2026 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274202; cv=none; b=iXivAnKwxQwJU9Wuk+Au1pOyTTO8JqC2qHlNG96GFmcFAYbWutvS4LOlcvboBiXiosd+rfo2HjrjHdbzhSvTvbjCSvGZU2QE0lkvTTNjivw8PHqsrEJ3RgarC+4T6DSFEY7MxpwhNjuDc6PqPQ7MAEG4ZArhRU4Cyllyphw1xjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274202; c=relaxed/simple;
	bh=82PfU4czKPk4flWyxMgo7L0m0KBmBz2GrrRTMVofLis=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=Guc58MDoN/4Ylg1Dfx+ldr3fA8Xt3K9yZhyJWNRhGZRffItllPnonxOXYYOkjOoQzDnqSao3u5oBZ+cMh4Ip37fsge+8CEw4rhKzry/D/0YG7nGR/uFrBj5Lbd4IVdABPG1ULVK6jwv68lZ1q+4hZdsEfHks/Ygcg0PVTHNm1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=locrian.net; spf=pass smtp.mailfrom=locrian.net; dkim=pass (2048-bit key) header.d=locrian.net header.i=@locrian.net header.b=TNuBZbGy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BreL684j; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=locrian.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=locrian.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=locrian.net header.i=@locrian.net header.b="TNuBZbGy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BreL684j"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 341A31D000F8;
	Tue,  1 Sep 2026 10:49:59 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-05.internal (MEProxy); Tue, 01 Sep 2026 10:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=locrian.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1788274199; x=1788360599; bh=82
	PfU4czKPk4flWyxMgo7L0m0KBmBz2GrrRTMVofLis=; b=TNuBZbGy3beCGUCUmF
	FkvFPe4wJ6E+RnpFeW5rNpyk0XTt8gogmipWAq27azip5yficfHWL7W/AQ+xzsFo
	i3KtxrT5RWHTneKSa89vd4k6Q8Kgja7iv5lJOa4FxR1yXU5dsLxFnm7jNubDBImG
	eJKZ9yOt3+MQ0vZ35ia3yy0QLShWi8dyehbSIODtCOZ7EN2LwRMPpxaNjUN7wKR0
	yTb+7Ij6BxIEdUXHIPe/ZduZEVzEwtzIjH6b5FD84i7cmIttNERsFDti6xkHqQKu
	N+DfuIJPZpA5G11MD47Mdh7ymAfORCNYkNxluQ0ruIFUQuaAnsgLvcf62lGwL1Yq
	4NXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788274199; x=1788360599; bh=82PfU4czKPk4flWyxMgo7L0m0KBm
	Bz2GrrRTMVofLis=; b=BreL684je0PkovnOQ8aE8ywMQIl/Givgh3KyALHgVQnV
	0hUWMogbTD/Z3Dl4zn+DIInuVC+mQkp9yRzot0NgeiugaTMWibrqpgYfPd99lWrg
	QNVgl5jAnAFzZlRTqZ7Kat9eRtaY5rNUplCxy2TDzaSz/VPYudlCgEyz4aflWOpU
	TSts2IP2O9qL1vhVxl3rRJN0CmrV4zNv6ArGWwnVht0d++ekL/+uZJ0JrRRnBl3b
	qk55ZZzIKDmS+UtvTFU5GsMv8y4vHctqamWPVDXMvGcP+/guRKrNhPSZtrwx2/nb
	CY4nuMuRLlLQHFToF+4/iTsgQR5E8Cr3v/k2mxhbXQ==
X-ME-Sender: <xms:FuaWaheTXDTD7wtukI2vlaaSQKk3G_snMlEWbIsrTH9cmtZrGMvm4w>
    <xme:FuaWaqAeVN4cjVLJv9tOn3OSr56fDlnzP1fkWg6JK3MlHAt9dgt99rpILLCKn4e5L
    -4_Ll1oJmpPc3NtRzXyZjZH_g1z5SNJ_qKIVY6mJZ1U83DSxefHpg>
X-ME-Proxy-Cause: dmFkZTGGIxyW7n89R/dIxkTQr1PdASvjHpBDI/c44zyKuhofCr2KnXDI2iy3aMENBjkHL0
    2GGTD9ksETgXy4rtDdTxdebRwni9gXJx4MRKX2XmTceCRH5DUwyL1B7C9rN/l4EfCq25W7
    m6yUZ5mA8FVDODRNvLngGyY9Jt0slHDVaDOj+BkVsFBXcpwzhIvcqMRG0AiUU5Hc3SWg/a
    +3maJsA3dR9m9c7FB0kzdqp9oPl4ngIhsleKn87eZRFP9v7I7DQ1DYgmYTKeCqScTrrBI3
    AGRKI/rXZ9S/aq7FkvQhPDNIZ1/qIdnc7kMQuJxyG1z4+SqHvM435oDJ5oAJXsqYMkVgqG
    r0nSXT0bw8PmMorOk8RtLFcv6RCVoZGLUheEWqtH7nBPe0OSPtBKtjnwYerpwayNaXWMF/
    xmCu9QADHnjE5/kq/dRkcdCGSFMn6DAuyDC1KVhbK6MkuQd6iA1zZL85c1Un3BUv6jWvBr
    SpbdibgDI3RT3nNfKZrbey/yz0K23zMAEDhSw7JNN30HYCaojIaDheIeDxOdJ2GljESFUu
    bkjNwbDwta4s/Xfwba+wDSDKPyWoanDHaDmf3SizgjIyakukf4wxgoErcEAznw/2/LrHVQ
    /bbHkKHI1oa0wLip5Qa16u7PjTXDgEwMQ1ESSF6YV8ycD05qqBzhky8sPP4A
X-ME-Proxy: <xmx:FuaWasr4a0xCSRPU-TYpGvTlr7TTwnFSDWQhzIeBPHnkW2io08gT7Q>
    <xmx:FuaWaorhuOqxncn2uRcoMlKgU3nCQaMelTStbKuZBh9T0VA1Z64-og>
    <xmx:FuaWasBsUjaof0Usp8ND56_f57v90he9LA1mhAG6My8Zx0He0g59Vg>
    <xmx:FuaWamvePrKGB7aCDHBz5kMWNB3Lu8xFlgcI7D3KzV-Pa81bgowz4g>
    <xmx:F-aWat2guCLS--kUcNUiBL7wHemhljkSUyjdx4JNIHdL1NNL_GJU8lXx>
Feedback-ID: icec1443c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2953E240009A; Tue,  1 Sep 2026 10:49:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 01 Sep 2026 07:49:37 -0700
From: "Benjamin Peterson" <benjamin@locrian.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jann Horn" <jannh@google.com>
Cc: "Jan Kara" <jack@suse.cz>, "Arjan van de Ven" <arjan@linux.intel.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, "Jake Edge" <jake@lwn.net>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-Id: <f5e8166a-88be-46c5-8939-1e5227ffe4c2@app.fastmail.com>
Subject: deadlock from exec_update_lock and reading procfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

After receiving a kernel with 6650527444da ("proc: protect ptrace_may_access() with exec_update_lock (part 1)"), we encountered a new deadlock in a FUSE server. The FUSE server reads /proc/PID/stat in the file flush callback, where PID is the pid of flushing process. This can deadlock in exec_update_lock acquisition when the flushing process is closing O_CLOEXEC files.

Specifically, a process running execve is blocked with this stack:

__schedule+0x505/0xc00
schedule+0x27/0xc0
request_wait_answer+0x158/0x2a0
__fuse_simple_request+0xd7/0x290
fuse_flush+0x1a4/0x1e0
filp_flush+0x30/0x60
filp_close+0x13/0x30
do_close_on_exec+0x114/0x160
begin_new_exec+0x553/0xb50
load_elf_binary+0x2da/0x1770
? load_misc_binary+0x275/0x390 [binfmt_misc]
bprm_execve+0x241/0x5f0
do_execveat_common.isra.0+0x182/0x1c0
__x64_sys_execve+0x36/0x40
do_syscall_64+0x87/0x180

while the FUSE server is blocked here:

__schedule+0x505/0xc00
schedule+0x27/0xc0
schedule_preempt_disabled+0x15/0x30
rwsem_down_read_slowpath+0x25c/0x480
down_read_killable+0x48/0xc0
do_task_stat+0x7f/0xec0
proc_single_show+0x51/0xc0
seq_read_iter+0x11f/0x460
seq_read+0x12d/0x160
vfs_read+0xe8/0x360
ksys_read+0x6d/0xf0
do_syscall_64+0x87/0x180


This problems seems to have been acknowledged as a theoretical possibility in the original patch review thread [1]. Now that it's a practical problem, is it feasible to move do_close_on_exec outside the scope of exec_update_lock?

Best regards, Benjamin

[1] https://lore.kernel.org/all/CAG48ez2pmuoTCZh_AVKDDLeQEYmm=gLMgThnqFhRMFfZvABpdw@mail.gmail.com/
