Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E73876BF
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779533940; cv=pass; b=Ryc9wFbQnULxTrVC2pOReepyS0IgG226kWvGKBOIWhgjzPDNb801HvE07qPY9O6wrHH2hFqKHc67c9NiPTDKMjzhZYe3b7Jf/njubVP3BmwKRWGzayu9vqxTzZhhBJgkmeHIKsvouTr5mCYXZHOt9f2miLhfO/QNLv1N0X9NEU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779533940; c=relaxed/simple;
	bh=nCmMwkBwUImlkzxWG3Un8vb2R7F6fTAERklhG+Bd4Lg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=s9nBeWqQhCjTLlEoS8YRe08MTLE0mIOeClpiAe1RqXAD2t22pTsJEPdDBgJym4WNtmnaU40fUUS37bsMyN1hxpMp+5mYYEKdHGalQ6axyAiTEgYI/RI1okj0qOarTiJVv+vm5BzpgG2woIUDeRFTpZ8bcU2oWmj+Y61UUdu7BYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjXZvTyz; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjXZvTyz"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so105466256d6.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 03:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779533938; cv=none;
        d=google.com; s=arc-20240605;
        b=SDjARk+oHu+BJH4SM/8KktjPPl9J3v21hOTM29zUzhaMlxKza9kRF7dFn5QOKFQaFx
         VCjpGfVpWgm+Gg4pAJc9/PnCDOV1RPp53ViRM3wpSbw7LRhS5Im+mf3qcvunqQYgjsHh
         0/HaoW39X2n5vVSJNzy7WyfQaoSDP7kdB9FK1EZ22CKZTjOgZ8FGrdHLnDYbKVY/0Lsg
         kBxXpJarvQRjR5WMrOXCUf3qSbaZQIduE8dGdix44Yl3Njq3Mepi3zesvx2qq48juiix
         gTFXqBcMdmxNl7TV4AQFFjHNVxfx9l963GBvYEMDKHTN2pDVqefLV2uYvVMhqFAqRmSB
         uXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nCmMwkBwUImlkzxWG3Un8vb2R7F6fTAERklhG+Bd4Lg=;
        fh=LUSPE6zGLraboG/hhhhBJ6UdLDvVWfxSDUj1F20U/NA=;
        b=dFm0GxKxvnqi7wOSa2XySCRuqleWPFqnhdTDitSBq0HnIS/IPT4tPilrFA6S0PgDJk
         UblcOduVKgxP+vTmRGszFi+0HZhjveljSiL7xHz7iy0kMy0u1iyq7BR5XLlpJt1OkOF5
         ox9ijTQOaxfDJ7YP7oD7fH5F4HVAejb8sZOI2gycXkLJ69bt5wfVwFf8MvHwH6auxGsO
         KZck4znuHcmwbHg33Mqx/8bFeJA1Zzpsr0dBKpsGRWoi2falHrQOaC/rt2/t17BmWasK
         LJQSafeBefwluRYqDCB2cSVeeMC0U5YtJuXivoYkVoeKTzlK1/Be3cpbFtpP5cjA6aje
         w0cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779533938; x=1780138738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nCmMwkBwUImlkzxWG3Un8vb2R7F6fTAERklhG+Bd4Lg=;
        b=IjXZvTyzZQ4sSnWU8Euii8yvJVIElpELWNS+QFkAWbqLsfCQ/br2ykrDpktyDV7Wnv
         zP6TPisEgR9ksHJBQONvyxep/w5ndliB6kHQR6LLrML8ph1B74Dwzwby+ijrcpMQILjB
         /WdEy3he30XQ1T1u/GufosWYHXaHg3MlCDkh8UqhpkNjKLECv64SxWDQ2XDij9MFmSpa
         pZvyZNtqZo3Hreyxh8lOr2cFkS4rF4wi+/Y8rfVm93mEWG1PYuQwvAurleWeUWc960A2
         DKG6gROBolet3gg4g7VhcVd7hP9OkUAVVtZOe2LegQwfhWrgGSVbklPU/jTXY9u+WcYc
         fDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779533938; x=1780138738;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCmMwkBwUImlkzxWG3Un8vb2R7F6fTAERklhG+Bd4Lg=;
        b=NjQ2o2zf4m/bEF1yIr7vCZ3t3Rb1c/nYoQ3PeOLuvGoHoBOH5vQQxxBp80DKIPKyrt
         N8OuxZ3ZGn0gLwcJHJALObQMr0H0BPCbxaZiidmiXo1cahxQx3QznQKI2tVlRzseWDr1
         FvidEoUY03nbKLy6t02TY8CNVqUc8qtb/KrGIaRg5ihlIJn8KzJT5lbppDZnHs7UYaE5
         65aF02hupeDCxPsooI7QUyZTFj51SqAqDIc1RK+406P2RxHV634MTpIHhz4/takfPGdg
         SUUgIFdEzARoEIVoWPYhgc2cKP86rkZmrCOF+X9HmYImLYlIJLv16nV/hsLwym7hUf9R
         hgPg==
X-Forwarded-Encrypted: i=1; AFNElJ/0xQs1OV4AEJyNfMIsew/04iVbr3baUBjAFfVETZyKbB5Wfcu93MZLaVArMzHmxayqTY+lkaL3qOHDzBNb@vger.kernel.org
X-Gm-Message-State: AOJu0YxQE7hoEWW3BDMUwQOVyD+S0SQjfe4jh3/PoJP8yrDd8KNZYWE2
	n8wILjpc75ljjdTWbBGhsST3VT6edTZpYQhJLGRfsDW9BhTD4/rcYck03djNzg2K5pPat4zrqlg
	YGMFraYu3DiMuld/9hlovfSBwSGjf0u8=
X-Gm-Gg: Acq92OGhCjIX3YT+GbmE+etyJco1copJ7FT9XyXExTEUAxhWuIB6+3fn9SuUrbAAS48
	ZfoIpAFz1zgYeavJg7rsCLi6fJA48BO/xHqRQwhh2wAtTrpOGfmwo7hh5QZE1rat79ccGisFOHW
	RikddoD99zeDjq3SpsahK5q/TBO+naugxndCiRUCYu1SD5pdwRjWRQCTxhm/nHeNFwQWi5o27b1
	CnjVvZBuQr24ZO4Vd50zO7lviiTeKalrCh6HmC+fyS57+zqJ5cO5V4RJovdH1HgkyHpgVaMnEII
	eR89mgF/xHvMd7ojPv9D9ln8Ks9QzQ==
X-Received: by 2002:a05:6214:2dc7:b0:8bd:de6d:c336 with SMTP id
 6a1803df08f44-8cc7b618aa7mr109111426d6.18.1779533937855; Sat, 23 May 2026
 03:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Sat, 23 May 2026 18:58:46 +0800
X-Gm-Features: AVHnY4IqQEf0ebjnvb9KBwhTvsLOAOAAl8rdT96fCM2j6_dXNlD1krgnGP2bRPE
Message-ID: <CAEkJfYPhWdd59RKmuNLJg-bkypHz7xiOwaWyNVu3A8CUqQCnvg@mail.gmail.com>
Subject: [BUG] iomap: NULL dereference in iomap_finish_folio_read after
 deferred failed read
To: brauner@kernel.org, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Dear developers and maintainers,

We encountered a NULL pointer dereference in the deferred buffered
read failure path. Unfortunately, no reproducer is available yet.

```
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 10774 Comm: kworker/0:9 Tainted: G L
7.1.0-rc2-g70390501d194-dirty #33 PREEMPT(full)
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events iomap_fail_reads
RIP: 0010:iomap_finish_folio_read+0x12c/0x2c0 fs/iomap/buffered-io.c:415
Code: 48 c1 e1 0c 48 c1 ea 03 4c 01 e9 80 3c 02 00 0f 85 6f 01 00 00
48 b8 00 00 00 00 00 fc ff df 4c 8b 6d 18 4c 89 ea 48 c1 ea 03 <80> 3c
02 00 0f 85 39 01 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b
RSP: 0018:ffa00000058ffb50 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 00000000fffffffb RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8263bc9e RDI: ffd40000023aab58
RBP: ffd40000023aab40 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff90b5ee97 R11: 00000000000009d8 R12: 0000000000000800
R13: 0000000000000000 R14: ff11000076809e80 R15: 0000000000000800
FS: 0000000000000000(0000) GS:ff11000183bb2000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6637788c38 CR3: 0000000036ca9000 CR4: 0000000000753ef0
DR0: 000000000000007f DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
<TASK>
__iomap_read_end_io+0x478/0x940 fs/iomap/bio.c:21
iomap_fail_reads+0xa4/0xe0 fs/iomap/bio.c:43
process_one_work+0xbe6/0x2030 kernel/workqueue.c:3467
process_scheduled_works kernel/workqueue.c:3576 [inline]
worker_thread+0x693/0xeb0 kernel/workqueue.c:3657
kthread+0x38d/0x4a0 kernel/kthread.c:436
ret_from_fork+0xb09/0xdb0 arch/x86/kernel/process.c:158
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
</TASK>
```

We analyzed the cause of this report. It seems that failed buffered
read bios are deferred to a global work item "failed_read_work". The
deferred worker still owns the bio/folio, but by the time it calls
`iomap_finish_folio_read()`, the folio may have been truncated,
invalidated, or otherwise detached from its mapping. In that case,
`folio->mapping` is NULL, but the error reporting path unconditionally
dereferences `folio->mapping->host`. This pattern still exists on the
latest kernel commit.

A possible fix could be avoiding the `folio->mapping->host`
dereference in the deferred failure worker, including storing a stable
inode/address_space reference when the read bio is submitted or
completed, or using `folio_mapping(folio)` in
`iomap_finish_folio_read()` and skipping `fserror_report_io()` if the
folio has been detached.

Best regards,
Yue
