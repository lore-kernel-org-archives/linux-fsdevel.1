Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649432;
	b=AEJ1vRKQSqgEgSGKu3n6U8e0pSEk7uddMa7zbKwCES2TP+aE1csq1o0otOg/0FWpMlIT
	 9+oDdJB3E+yvzZOnlllHcCA/uen69ojSer0sw97EJVhvYvgLmXTusAZVUmjXO/Q7w5sH3
	 hiwScOkSBbO3RfcXw9VD7ryTmcdni7QZbBoUfMt81G6zRf1w328eojOk1294HTZRH7RPp
	 UWZ5ETvsAxIdWsNTaPUy37dinr4cUzL+lNM3FaiUZDuJkMT6Mr/28LYFMTsvlb+H4lENb
	 sNYcx5bcSWfQ01NwzK6m5+QqnYNMYgHB2GJi7lkxb2BtO8fMf2UQCxIYjZiqI2lhLXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=e35aD9xDuc1hKVMZ4DHpu/O6GiR6BdX7QfpIMiYdEOE=;
	b=D+zEMi8Evw+9PpM2mlptY4oSy/cequv6e/w2CdSzeavQX097/e54DSKWuPUgnrfPhFah
	 I8rFmaj0gK5BQ8neAOPLnyRoWZT1tUDfh4W6xJ5b8qfT7ZIX6YmF+H5MGJhxdujx6m7ae
	 +yA38x4GW5RSGzcg+lt/ThMdKG9nSkAnhF+E/Q6c1Q+X7kEb9i9Hy31463N/vzjDJK+/D
	 rnUWjxH/a7KtbazkDy+qPZ2lBiXe6MNgzupR4Tf9lExeaUUtEAD/J5dhQfNrGe05KkDV7
	 A2zpbVLYgFTKOMuoCcgR6HcFU9Pr9RXGXS31yEq55Bfv3HFyH3Ymi/J8mNrKtFPQgRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q4WIHuji;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E5C606A323
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 23:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E5C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q4WIHuji
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so35151205e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 15:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795649431; x=1796254231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e35aD9xDuc1hKVMZ4DHpu/O6GiR6BdX7QfpIMiYdEOE=;
        b=q4WIHujiO3KUwyueidP7nGuHFOYg3YjRfJekEql5FlsaKNifD52JgCVIFcJlCa7U2J
         GF248vhoTd18/9L2jk+s0vC/1F7ULwBlkvIwGgujigVNH5KLO9NFl3xnBqK3qAZ4slAs
         57n0Vebr1TNCj5k+2AmSWtjPwx8lod+dBBBA/uDiAU+5+rS+L0SRaskI5ly5rVOIirBf
         glBTF5zskUrMaSXWJjsojpYGJFHPC0956B4ZKTqL/JjxX1P6YTIMs7OXX+jU+aQMY2Jx
         n4Ep3J3oNqsFTcw+OOGHrytcW1JoiewpfbdbCWskz7OmmCD3tXiL8Y0jkfKW4II2F340
         ZJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649431; x=1796254231;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e35aD9xDuc1hKVMZ4DHpu/O6GiR6BdX7QfpIMiYdEOE=;
        b=LVlCsrxbpXQspKLsa3jrjLAsb+LIQcqTTPa2kLUqh7GcQ34udMUdsSNTuQz3VuyL5/
         ytiOMi6LwdqnvoEG5GFKdfEx/U9B3jvEpg9L3y6VFMmf2N5CFxc5gKdq7IfRvWpZkwyc
         Pce4/odT6+XMJGGBUvXscJoN24mgIrriZPJsRgLUeHw5enBwKh0WLnz6jDYfcog/4IDN
         GGQT81wxU/Wln1au2UN7BWsP3FUssdiParBL5z2gS0d6h+x6c316ncPOTnK6Cdu0nbye
         VD5Ag+j/FHPkVr+vQI1/lTcdJ8sMKw/lhZiGE+ebw6AEGZU6HaakJ68tEgOYRGHlY1Kh
         YtDQ==
X-Forwarded-Encrypted: i=1; AL+hErFgsnfzK2TUlbr2MGH/lKknQ0+Rwqdz0Pm0LoFVy/3FzYp29/ps253S2ITR+Qt9ti9Y6pEIue79C5wH1ni+@vger.kernel.org
X-Gm-Message-State: APuU4Z+bEnH3dLFsvl2QZq6Pq9CxyjU8EBkITfiqxt4V9qBqgpEoN28U
	Kza7r8gE5/CjySwAlYoj4DAosKU4aizBr+s9aQDInl9spITlx6DtPVR1
X-Gm-Gg: AZFdTZche2+kZPc/9rg8AnJE/crExvJ35UjUsDgIsINdSeKW7/4qPWVeBnp0jczLUrb
	5/QTu29/Ob/iO5SI3T41C+s0MnYwZA3Eb1jAyRgWxZSEMP1DQaYRXaroQhcLXmzwkCb2O0NRpqk
	K+1uyieh9EE94Z3ZNl52IaWvw+breuAwCDVnIz96a04K50YnKcdVP+Tm4xqPtpAujm/B9J8239w
	8Fn/mKfKFLtEJjvxobHX8TnoZSYOHLeO/UGFBYiwcw1cqryVJRwYhKfrUURZvXq+f7BeRqF9NgG
	kp2IHc2kiJiQcvMiuUChJHsJnYMFfgxnYdlm2XEQhygb7O521AmH4GTGUK6JBFcZ3oMu3vfd1Vw
	LoN7YMx+IpipELfoyL5C9FNVJVE/jKgi450SspYF8SGDpiPwMv6Bt2LFh2PIYmNA29kosdQl3l5
	BAhpk+1YBXESYTtQiSY8+NSftu4lEobjbh8tKdVlB0soBgHtAYsEkTPJrbjiKEpTZEPf+AFDi3k
	/E9dYxXo+G/n2qcRcT+6mOuEsDJMMudvXJ8cN74j8YcFsPs/o8gKhmtGA8L09xLwvVid6Scl7Qi
	Rh2QwPmNhkESCcHmIghe4OQ3Al4q4m2A8Lk2fCWJUJmw6J3ZP0UOvw8p5iq700YcEk1mkxYTKV0
	7v0SzirJrnn/jTUdiQCRJ5BC+7pQdK4w=
X-Received: by 2002:a05:600c:4f50:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4bb888063f3mr484937095e9.16.1795649430462;
        Wed, 25 Nov 2026 15:30:30 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm35729850f8f.56.2026.11.25.15.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:30:29 -0800 (PST)
From: =?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
To: linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RFC 00/19] riscv: Add initial support for Espressif ESP32-P4
Date: Wed, 25 Nov 2026 23:30:01 +0000
Message-ID: <20261125233020.1380594-1-vitorhg20080@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This series of patches adds the initial support for the Espressif's
ESP32-P4 on the Waveshare ESP32-P4-Module-DEV-KIT. It boots in M-mode on
a RV32 NOMMU kernel with one HP hart.

The series adds CLIC trap handling, drivers for clic and for interrupt
matrix, and extends the CLINT timer driver. It restores a previously
removed ESP32 UART driver with ESP32-P4 UART support and early console
support. It also synchronizes the instructions written to the PSRAM,
aligns the init data to the ESP32-P4 PMP granularity, and it adds DT
bindings and the board devicetree.

The boot firmware initializes PSRAM, loads the kernel, DTB and the
initramfs from the microSD, and it supplies the timebase-frequency
before jumping into the kernel.

The bootloader source and microSD boot instructions are available at:
https://github.com/pushdword/waveshare-esp32-p4-bootloader/blob/390880e881208ab16aa16eb520b3e5ea0c63c0a2/README.md

I tested this series on the hardware, the Waveshare
ESP32-P4-Module-DEV-KIT with the ESP32-P4 revision v3.2 with 32MB of
PSRAM. The kernel booted to the UART shell from the initramfs. The
/proc/interrupts showed the CLINT IRQ's increased, UART0 interrupts were
routed through the interrupts matrix. 

It would be nice to you all send feedback on restoring the interrupted
CLIC level before irq_exit_rcu() and the interface for propagating
instruction-cache sync failures to NOMMU executable loading, and signal
setup.

AI disclaimer: I have used 6.2-Sol to assist development and to assist
debug/troubleshoot some ongoing issues. I have used Codex's 6-Sol
with Daybreak Blue enabled to generate peer-review-like report to
pinpoint potential security issues regarding the patches. I manually
reviewed and validated each change, including the AI-assisted changes.
I also manually tested each change on the hardware as described above.

Vítor Hugo Silva (19):
  riscv: Prepare ESP32-P4 early CLIC trap vectors
  riscv: Handle ESP32-P4 CLIC trap context
  dt-bindings: interrupt-controller: Add Espressif ESP32-P4 CLIC
  irqchip: Add Espressif ESP32-P4 CLIC support
  dt-bindings: interrupt-controller: Add Espressif ESP32-P4 interrupt
    matrix
  irqchip: Add Espressif ESP32-P4 interrupt matrix support
  dt-bindings: timer: Add Espressif ESP32-P4 CLINT
  clocksource/drivers/timer-clint: Add Espressif ESP32-P4 support
  dt-bindings: serial: Add Espressif ESP32-P4 UART
  serial: esp32: Restore the ESP32 UART driver
  serial: esp32: Add support for the ESP32-P4 UART
  serial: esp32: Rearm TX interrupts when the FIFO is full
  serial: esp32: Add early console support for ESP32-P4
  riscv: Synchronize instructions written to ESP32-P4 PSRAM
  riscv: Align init data to the ESP32-P4 PMP granularity
  dt-bindings: riscv: Add Waveshare ESP32-P4-Module-DEV-KIT
  dt-bindings: riscv: cpus: Document Espressif ESP32-P4 HP harts
  riscv: dts: Add Waveshare ESP32-P4-Module-DEV-KIT
  MAINTAINERS: Add the Espressif ESP32-P4 platform

 .../esp,esp32p4-clic.yaml                     |  53 +
 .../esp,esp32p4-intmtx.yaml                   |  67 ++
 .../devicetree/bindings/riscv/cpus.yaml       |  17 +-
 .../devicetree/bindings/riscv/espressif.yaml  |  22 +
 .../bindings/serial/esp,esp32-uart.yaml       |   4 +-
 .../bindings/timer/sifive,clint.yaml          |  28 +
 MAINTAINERS                                   |  14 +
 arch/riscv/Kconfig.socs                       |   9 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/espressif/Makefile        |   2 +
 .../esp32p4-waveshare-module-dev-kit.dts      |  46 +
 arch/riscv/boot/dts/espressif/esp32p4.dtsi    |  64 ++
 arch/riscv/include/asm/asm-prototypes.h       |   4 +
 arch/riscv/include/asm/cacheflush.h           |   6 +
 arch/riscv/include/asm/ptrace.h               |   4 +
 arch/riscv/kernel/asm-offsets.c               |   3 +
 arch/riscv/kernel/entry.S                     |  67 ++
 arch/riscv/kernel/head.S                      |  13 +
 arch/riscv/kernel/patch.c                     | 132 ++-
 arch/riscv/kernel/signal.c                    |   6 +-
 arch/riscv/kernel/traps.c                     |   4 +
 arch/riscv/kernel/vmlinux.lds.S               |   4 +
 drivers/clocksource/timer-clint.c             |  57 +-
 drivers/irqchip/Makefile                      |   2 +
 drivers/irqchip/irq-esp32p4-clic.c            | 178 ++++
 drivers/irqchip/irq-esp32p4-intmtx.c          | 139 +++
 drivers/tty/serial/Kconfig                    |  15 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/esp32_uart.c               | 940 ++++++++++++++++++
 fs/binfmt_flat.c                              |   6 +-
 fs/exec.c                                     |  10 +-
 include/linux/cacheflush.h                    |   7 +
 32 files changed, 1910 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/esp,esp32p4-clic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/esp,esp32p4-intmtx.yaml
 create mode 100644 Documentation/devicetree/bindings/riscv/espressif.yaml
 create mode 100644 arch/riscv/boot/dts/espressif/Makefile
 create mode 100644 arch/riscv/boot/dts/espressif/esp32p4-waveshare-module-dev-kit.dts
 create mode 100644 arch/riscv/boot/dts/espressif/esp32p4.dtsi
 create mode 100644 drivers/irqchip/irq-esp32p4-clic.c
 create mode 100644 drivers/irqchip/irq-esp32p4-intmtx.c
 create mode 100644 drivers/tty/serial/esp32_uart.c


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.1

