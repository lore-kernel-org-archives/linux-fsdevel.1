Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A4256D
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780790610; cv=none; b=ujPBmd5OU6k30xGFL3xYe4jnxCyFBpJm1STdXw/ElKI0n6YGXbt5dqYxhu5iM123ti5jpkDUaUbN6l2vpyxUCdK9xLDaBey8bF4LO1t4u++Gy7UKY2jCgetfbza1vfEOyieddmGuhebEL/jreWCjdpE3RuWF8PehUpk0QByvDis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780790610; c=relaxed/simple;
	bh=xvRW5PX4uhPcXu8XFV8IEI4GCL+L9q3YidtLQFAEJaI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SaJPRTq++ikjtbtzDM3EfuhY/re8oxvQiB+MNSA97oASLJ+ojre1AD1WgGBW3GPF4xxdJZl8NURReJDUt59KmxUfyb+AOqj5kBwjPlKXgcXBC32wnitm/eaUFZBTSk/+NMRfyo6pUeqzP5G9pnR2oy9voFrbstwC2KoMgQnHIyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hLT0AIZj; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hLT0AIZj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=qjf3eupsyfe3hkgoxazhnujlhq.protonmail; t=1780790603; x=1781049803;
	bh=hXPTXWZCurFrHf8ToiQLnOKDItHN4wr7tY2PS+NVrgU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hLT0AIZjtzG/6Xq62mXmgjep5aWo/5RfScTAeylDEQUiC2M3DgiT34I7OIPuCwXF7
	 Et3ZjMJqcnNCaOMR5c87sh12hkpq1rWKMs5pEQudC1/JLOxvfH93tm/nrAapC2OhWz
	 XkXjnqN4p1B3SQAJiiaYDDkCgveN0xBTRBjQ4Qk4xsylgmkn6/jbgLSgzt7E6gnGJ9
	 ACG1ilGXPAHvrs5GtyM1G+e/bFUxYmZG10MkR/gb/h9pGL6oJ53ms1soydmpwgDJNP
	 KD4JSW+kWs0XkyCxFW/IuR+SjNkczUFKRXElrCHeCttuAQ18WFnSTgWrPoRgs+gJ0U
	 A31SdRBNf/uWw==
Date: Sun, 07 Jun 2026 00:03:18 +0000
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v2] ntfs: fix u16 truncation of restart-area length check
Message-ID: <20260607000312.207960-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: f181afd72a383f22441d13065177e728355c1b2c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ntfs_check_restart_area() validates that the $LogFile restart area and
its trailing log client record array fit within the system page size:

=09u16 ra_ofs, ra_len, ca_ofs;
=09...
=09ra_len =3D ca_ofs + le16_to_cpu(ra->log_clients) *
=09=09=09sizeof(struct log_client_record);
=09if (ra_ofs + ra_len > le32_to_cpu(rp->system_page_size) || ...)
=09=09return false;

ra_len is u16, but the right-hand side is computed in size_t
(sizeof(struct log_client_record) =3D=3D 160). Both ca_ofs and log_clients
come straight from the on-disk restart area. With an on-disk
log_clients of 410 the product 410 * 160 =3D 65600; adding ca_ofs and
storing into the u16 ra_len truncates modulo 65536 (e.g. ca_ofs 64
gives ra_len 128), so the "fits in the page" check passes even though
the client array described by log_clients extends far beyond the page.

ntfs_check_log_client_array() then walks the array bounded only by the
on-disk log_clients count:

=09cr =3D ca + idx;
=09if (cr->prev_client !=3D LOGFILE_NO_CLIENT) ...

For log_clients 410 it dereferences records up to ca + 409 * 160,
~64 KiB past the kvzalloc(system_page_size) restart-page buffer -- an
out-of-bounds read of attacker-controlled extent, reachable when a
crafted NTFS image is mounted (load_and_check_logfile() at mount time).
This is the in-kernel analogue of CVE-2022-30789, fixed in the ntfs-3g
userspace driver but never in this revived classic driver.

Compute the restart-area length in a u32 so the existing bounds check
rejects an over-large client array instead of being defeated by the
truncation. Widen ra_ofs and ca_ofs to u32 as well: both are loaded
from __le16 on-disk fields and every comparison already promotes to
int/size_t, so this changes no result and keeps the declaration uniform.

Fixes: 1e9ea7e04472 ("Revert \"fs: Remove NTFS classic\"")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2: widen all three locals (ra_ofs, ra_len, ca_ofs) to u32, not just
    ra_len, per David Laight's review. The fs_bits/ilog2() cleanup David
    suggested will follow as a separate patch (the current loop computes
    ilog2()+1, so it is not a drop-in). v1 went out quoted-printable via
    Proton Mail; this is resent as plain text.

Reproduced on a KASAN build (in-kernel ntfs, fresh-boot slab) by
mounting a crafted image whose $LogFile restart area sets
log_clients=3D410 (ra_len truncates to a value that passes the
system-page-size check):

  BUG: KASAN: slab-out-of-bounds in ntfs_check_logfile+0x1e52/0x2460 [ntfs]
  Read of size 2 ... by task mount
    (cr->prev_client, with ntfs_check_log_client_array() inlined)
    ntfs_fill_super -> ntfs_iget -> ntfs_check_logfile
  Allocated by task ...: __kasan_kmalloc -- the kvzalloc(system_page_size)
  restart-page buffer (the OOB read lands at buffer_base + system_page_size=
)

With this patch the same image is rejected by the existing
ntfs_check_restart_area() bound (ra_len is no longer truncated), so
ntfs_check_log_client_array() is never reached, no OOB access occurs,
and the mount fails over to read-only. A clean image is unaffected.
Full A/B logs available on request.

 fs/ntfs/logfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -132,7 +132,7 @@ static bool ntfs_check_restart_area(struct inode *vi, s=
truct restart_page_header *rp)
 {
 =09u64 file_size;
 =09struct restart_area *ra;
-=09u16 ra_ofs, ra_len, ca_ofs;
+=09u32 ra_ofs, ra_len, ca_ofs;
 =09u8 fs_bits;

 =09ntfs_debug("Entering.");
--
2.43.0

